import 'dart:async';
import 'package:doculode/core/common/auth/domain/usecases/get_user_stream.dart';
import 'package:doculode/core/constants/app_enums.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:doculode/core/utils/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ValidateEmailUseCase _validateEmail;
  final RequestOtpUseCase _requestOtp;
  final VerifyOtpUseCase _verifyOtp;
  final ResendOtpUseCase _resendOtp;
  final ValidateOTPUseCase _validateOtp;
  late StreamSubscription _authUserSubscription;
  final GetAuthUserStream _getAuthUserStream;
  final UserLoggedInUseCase _isUserLoggedIn;

  SignInBloc({
    required ValidateEmailUseCase validateEmail,
    required RequestOtpUseCase requestOtp,
    required VerifyOtpUseCase verifyOtp,
    required ResendOtpUseCase resendOtp,
    required ValidateOTPUseCase validateOtp,
    required GetAuthUserStream getAuthUserStream,
    required UserLoggedInUseCase isUserLoggedIn,
  })  : _validateEmail = validateEmail,
        _requestOtp = requestOtp,
        _verifyOtp = verifyOtp,
        _resendOtp = resendOtp,
        _validateOtp = validateOtp,
        _getAuthUserStream = getAuthUserStream,
        _isUserLoggedIn = isUserLoggedIn,
        super(const SignInState()) {
    on<FormFlowChanged>(_onFormFlowChanged);
    on<RequestOtpForEmail>(_onRequestOtpForEmail);
    on<EmailChanged>(_onEmailChanged);
    on<OtpChanged>(_onOtpChanged);
    on<OtpVerificationSubmitted>(_onOtpVerificationSubmitted);
    on<ResendOtpRequested>(_onResendOtpRequested);
    on<OtpVerifiedSuccess>(_otpVarifiedSuccefully);
    on<MagicLinkVerificationSubmitted>(_onMagicLinkVerificationSubmitted);

    _authUserSubscription = _getAuthUserStream().listen((user) {
      // Handle user changes, e.g., if user logs out while on this screen
      if (user == null) {
        // Optionally, navigate away or show a message
        log('ProfileSetupBloc: Auth user stream detected logout');
      } else {
        add(const OtpVerifiedSuccess());
      }
    });
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<SignInState> emit) async {
    final result = await _validateEmail(event
        .email); // Assume this use case returns Either<Failure, void> for simplicity
    result.fold(
      (failure) => emit(state.copyWith(
          email: event.email, emailError: () => failure.message)),
      (success) =>
          emit(state.copyWith(email: event.email, emailError: () => null)),
    );
  }

  void _onFormFlowChanged(FormFlowChanged event, Emitter<SignInState> emit) {
    if (event.targetFlow == SignInFlow.email &&
        state.currentFlow == SignInFlow.otpInput) {
      emit(state.copyWith(
          currentFlow: SignInFlow.email,
          otp: '',
          otpInputError: () => null,
          activeOperation: SignInOperation.none,
          operationStatus: OperationStatus.idle,
          operationError: () => null));
    } else {
      emit(state.copyWith(currentFlow: event.targetFlow));
    }
  }

  Future<void> _onRequestOtpForEmail(
      RequestOtpForEmail event, Emitter<SignInState> emit) async {
    if (!state.isEmailReadyForOtpSend) {
      emit(state.copyWith(
          emailError: () => "Please enter a valid email address."));
      return;
    }

    // Set operation in progress
    emit(state.copyWith(
        activeOperation: SignInOperation.sendingInitialOtp,
        operationStatus: OperationStatus.inProgress,
        operationError: () => null));

    final result = await _requestOtp(state.email);

    result.fold(
      (failure) {
        // On failure, keep the activeOperation but update status
        emit(state.copyWith(
          operationStatus: OperationStatus.failure,
          operationError: () => failure.message,
        ));
      },
      (success) {
        // On success, move to OTP input flow
        emit(state.copyWith(
          operationStatus: OperationStatus.success,
          currentFlow: SignInFlow.otpInput,
        ));
      },
    );
  }

  Future<void> _onOtpChanged(
      OtpChanged event, Emitter<SignInState> emit) async {
    final result = await _validateOtp(event.otp);
    String? otpError;
    result.fold(
      (failure) => otpError = failure.message,
      (_) => otpError = null,
    );
    final otpValue =
        event.otp.length > 6 ? event.otp.substring(0, 6) : event.otp;
    emit(state.copyWith(otp: otpValue, otpInputError: () => otpError));
    if (otpValue.length == 6 && otpError == null) {
      add(const OtpVerificationSubmitted());
    }
  }

  Future<void> _onOtpVerificationSubmitted(
      OtpVerificationSubmitted event, Emitter<SignInState> emit) async {
    if (!state.isOtpReadyForVerification) {
      emit(state.copyWith(
          otpInputError: () => "Please enter a valid 6-digit OTP."));
      return;
    }

    // Set operation in progress
    emit(state.copyWith(
        activeOperation: SignInOperation.verifyingOtpCode,
        operationStatus: OperationStatus.inProgress,
        operationError: () => null));

    final params = VerifyOtpParams(email: state.email, otp: state.otp);
    final result = await _verifyOtp(params);

    result.fold(
      (failure) {
        // On failure, keep the activeOperation but update status
        emit(state.copyWith(
          operationStatus: OperationStatus.failure,
          operationError: () => failure.message,
        ));
      },
      (success) => add(const OtpVerifiedSuccess()),
    );
  }

  Future<void> _onResendOtpRequested(
      ResendOtpRequested event, Emitter<SignInState> emit) async {
    // Set operation in progress
    emit(state.copyWith(
        activeOperation: SignInOperation.resendingOtp,
        operationStatus: OperationStatus.inProgress,
        operationError: () => null));

    final result = await _resendOtp(state.email);

    result.fold(
      (failure) {
        // On failure, keep the activeOperation but update status
        emit(state.copyWith(
          operationStatus: OperationStatus.failure,
          operationError: () => failure.message,
        ));
      },
      (success) {
        // On success, just update status
        emit(state.copyWith(
          operationStatus: OperationStatus.success,
        ));
      },
    );
  }

  FutureOr<void> _otpVarifiedSuccefully(
      OtpVerifiedSuccess event, Emitter<SignInState> emit) {
    emit(state.copyWith(
      operationStatus: OperationStatus.success,
      currentFlow: SignInFlow.otpVerified,
    ));
  }

  FutureOr<void> _onMagicLinkVerificationSubmitted(
      MagicLinkVerificationSubmitted event, Emitter<SignInState> emit) async {
    emit(state.copyWith(
        activeOperation: SignInOperation.verifyingMagicLink,
        operationStatus: OperationStatus.inProgress,
        operationError: () => null));
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn = await _isUserLoggedIn(NoParams());
    isLoggedIn.fold(
      (failure) => emit(state.copyWith(
        operationStatus: OperationStatus.failure,
        operationError: () => failure.message,
      )),
      (success) {
        if (success) {
          emit(state.copyWith(
            operationStatus: OperationStatus.success,
          ));
        } else {
          emit(state.copyWith(
            operationStatus: OperationStatus.failure,
            operationError: () =>
                "Your login link is invalid or has expired. Please try again.",
          ));
        }
      },
    );
  }
}
