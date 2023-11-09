import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/firebase/firebase_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseService _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  Future<void> logInWithCredentials(bool isDesktopAuth) async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      LoginStatus status = LoginStatus.initial;
      _authRepository.isDesktopAuth = isDesktopAuth;
      bool success = await _authRepository.signInWithMicrosoft();
      if (success) {
        status = LoginStatus.success;
      }
      emit(state.copyWith(status: status));
    } catch (_) {}
  }
}
