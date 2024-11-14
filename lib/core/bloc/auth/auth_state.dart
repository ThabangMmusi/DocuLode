part of 'auth_bloc.dart';

enum AuthStatus { unknown, loggedIn, loggedInNotSet, loggedOff, authenticating }

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticating() : this._(status: AuthStatus.authenticating);

  const AuthState.loggedIn({required AppUser user})
      : this._(status: AuthStatus.loggedIn, user: user);

  const AuthState.loggedInNotSet({required AppUser user})
      : this._(status: AuthStatus.loggedInNotSet, user: user);

  const AuthState.loggedOff() : this._(status: AuthStatus.loggedOff);

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
