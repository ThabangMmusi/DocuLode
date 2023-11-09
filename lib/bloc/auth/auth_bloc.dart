import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../_utils/logger.dart';
import '../../models/app_user/app_user.dart';
import '../../models/course_model.dart';
import '../../services/firebase/firebase_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService _authRepository;
  StreamSubscription<AppUser?>? authUserSubscription;
  final testMode = false;
  AuthBloc({
    required FirebaseService authRepository,
  })  : _authRepository = authRepository,
        super(
          const AuthState.unknown(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthAuthenticating>(_onAuthenticating);

    authUserSubscription = _authRepository.onUserChanged
        .asBroadcastStream()
        .listen((authUser) async {
      log("Auth User: $authUser");
      if (authUser != null) {
        add(AuthAuthenticating());
        var course = await _authRepository.getCourseDetails();
        add(AuthUserChanged(user: authUser, courseDetails: course));
        // });
      } else {
        add(const AuthUserChanged(user: null, courseDetails: null));
      }
    });
  }

  void _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      event.user != null
          ? AuthState.authenticated(
              user: event.user!, courseDetails: event.courseDetails!)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    authUserSubscription?.cancel();
    return super.close();
  }

  void _onAuthenticating(
    AuthAuthenticating event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState.authenticating());
  }
}
