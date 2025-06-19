import 'package:equatable/equatable.dart';

class UserStatusEntity extends Equatable {
  final bool isNewUser;
  final String? userId; // Might be available if new, or for existing
  // Add any other relevant user info received at this stage

  const UserStatusEntity({required this.isNewUser, this.userId});

  @override
  List<Object?> get props => [isNewUser, userId];
}
