import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/cubits/cubits_enum.dart';

import '../../commands/app/signin_with_token_command.dart';

part 'desktop_auth_state.dart';

class DesktopAuthCubit extends Cubit<DesktopAuthState> {
  DesktopAuthCubit() : super(DesktopAuthState.initial());

  Future<void> loginWithArgs(String args) async {
    if (state.status == CubitStatus.submitting) return;
    emit(state.copyWith(args: args, status: CubitStatus.submitting));

    if (await SignInWithTokenCommand().finishUp(args)) {
      emit(state.copyWith(status: CubitStatus.success));
    }
    emit(state.copyWith(status: CubitStatus.error));
  }
}
