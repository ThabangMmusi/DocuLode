part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthAuthenticating extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged({this.user, this.courseDetails});

  final AppUser? user;
  final CourseModel? courseDetails;
  // final User? authUser;

  @override
  List<Object?> get props => [user];
}
