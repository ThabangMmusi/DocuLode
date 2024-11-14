import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/injection_container.dart';

import '../../../_utils/logger.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../common/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService _authRepository = serviceLocator<FirebaseService>();
  StreamSubscription<AppUser?>? authUserSubscription;
  final testMode = false;
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthAuthenticating>(_onAuthenticating);

    authUserSubscription = _authRepository.onUserChanged
        .asBroadcastStream()
        .listen((authUser) async {
      log("Auth User: $authUser");
      if (authUser != null) {
        // add(AuthAuthenticating());
        // var course = await _authRepository.getCourseDetails();

        add(AuthUserChanged(user: authUser));
        // });
      } else {
        add(const AuthUserChanged());
      }
    });
  }

  void _onUserChanged(AuthUserChanged event, emit) {
    AuthState newState;
    if (event.user != null) {
      newState = AuthState.loggedIn(user: event.user!);
    } else {
      newState = const AuthState.loggedOff();
    }
    emit(newState);
  }

  void _onLogoutRequested(AuthLogoutRequested event, emit) {
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    authUserSubscription?.cancel();
    return super.close();
  }

  void _onAuthenticating(AuthAuthenticating event, emit) {
    emit(const AuthState.authenticating());
  }
}
