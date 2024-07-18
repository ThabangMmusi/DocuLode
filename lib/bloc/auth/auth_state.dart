part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, authenticating }

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;
  final CourseModel? courseDetails;
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
    this.courseDetails,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticating() : this._(status: AuthStatus.authenticating);

  const AuthState.authenticated(
      {required AppUser user, required CourseModel courseDetails})
      : this._(
            status: AuthStatus.authenticated,
            user: user,
            courseDetails: courseDetails);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [
        status,
        user,
        courseDetails,
      ];
}
