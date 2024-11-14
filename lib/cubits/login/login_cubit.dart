import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/firebase/firebase_service.dart';
import '../cubits_enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseService _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  Future<void> logInWithCredentials(bool isDesktopAuth) async {
    if (state.status == CubitStatus.submitting) return;
    emit(state.copyWith(status: CubitStatus.submitting));
    try {
      CubitStatus status = CubitStatus.initial;
      _authRepository.isDesktopAuth = isDesktopAuth;
      bool success = await _authRepository.signInWithMicrosoft();
      if (success) {
        await Future.delayed(const Duration(seconds: 2));
        status = CubitStatus.success;
      }
      emit(state.copyWith(status: status));
    } catch (_) {}
  }
}
