import 'dart:async';
import 'package:doculode/core/common/auth/domain/usecases/get_user_stream.dart';
import 'package:doculode/core/constants/app_enums.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithMicrosoftUseCase _signInWithMicrosoftUseCase;
  late StreamSubscription _authUserSubscription;
  final GetAuthUserStream _getAuthUserStream;

  SignInBloc({
    required SignInWithMicrosoftUseCase signInWithMicrosoftUseCase,
    required GetAuthUserStream getAuthUserStream,
  })  : _signInWithMicrosoftUseCase = signInWithMicrosoftUseCase,
        _getAuthUserStream = getAuthUserStream,
        super(const SignInState()) {
    _authUserSubscription = _getAuthUserStream().listen((user) {
      if (user != null) {
        add(const OtpVerifiedSuccess());
      }
    });
    on<SignInWithMicrosoft>(_onSignInWithMicrosoft);
    on<OtpVerifiedSuccess>(_otpVarifiedSuccefully);
    on<MagicLinkVerificationSubmitted>(_onMagicLinkVerificationSubmitted);
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }

  Future<void> _onSignInWithMicrosoft(
      SignInWithMicrosoft event, Emitter<SignInState> emit) async {
    emit(state.copyWith(
        activeOperation: SignInOperation.microsoftSignIn,
        operationStatus: OperationStatus.inProgress,
        operationError: () => null));

    final result = await _signInWithMicrosoftUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        operationStatus: OperationStatus.failure,
        operationError: () => failure.message,
      )),
      (_) {
        emit(state.copyWith(currentFlow: SignInFlow.browserSignIn));
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
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(
            operationStatus: OperationStatus.failure,
            operationError: () =>
                "Your login link is invalid or has expired. Please try again.",
          ));}
}
