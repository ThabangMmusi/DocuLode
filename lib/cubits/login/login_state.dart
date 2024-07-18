part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final CubitStatus status;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      status: CubitStatus.initial,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    CubitStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
