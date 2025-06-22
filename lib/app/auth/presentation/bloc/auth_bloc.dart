import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:doculode/app/auth/domain/usecases/get_current_user.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUserStream _getAuthUserStream;
  final SignOut _signOut;
  late final StreamSubscription<AppUser?> _authUserSubscription;
GetAuthUserStream getAuthUserStream() => _getAuthUserStream;
  AuthBloc({
    required GetCurrentUser getCurrentUser,
    required SignOut signOut,
    required GetAuthUserStream authUserStream,
  })  : _getAuthUserStream = authUserStream,
        _signOut = signOut,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthAuthenticating>((_, emit) => emit(const AuthState.authenticating()));

    _authUserSubscription = _getAuthUserStream.call().listen((authUser) {
      add(AuthUserChanged(user: authUser));
    });
  }

  void _onUserChanged(AuthUserChanged event, emit) {
    emit(event.user != null
        ? AuthState.loggedIn(user: event.user!)
        : const AuthState.loggedOff());
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOut(NoParams());
    emit(const AuthState.loggedOff());
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }
}
