part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthAuthenticating extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final AppUser? user;

  const AuthUserChanged({this.user});

  @override
  List<Object?> get props => [user];
}
