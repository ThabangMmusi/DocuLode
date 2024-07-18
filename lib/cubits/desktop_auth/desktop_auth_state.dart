part of 'desktop_auth_cubit.dart';

class DesktopAuthState extends Equatable {
  final String? args;
  final CubitStatus status;

  const DesktopAuthState({this.args, required this.status});

  factory DesktopAuthState.initial() =>
      const DesktopAuthState(status: CubitStatus.initial);

  @override
  List<Object?> get props => [args, status];

  DesktopAuthState copyWith({String? args, required CubitStatus status}) =>
      DesktopAuthState(args: args ?? this.args, status: status);
}
