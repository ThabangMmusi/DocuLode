import 'package:doculode/features/sign_in/domain/entities/user_status_entity.dart'; // Adjust path
import 'package:equatable/equatable.dart';

class UserStatusDto extends Equatable {
  final bool isNewUser;
  final String? userId;
  // Add any other fields your API returns for this response

  const UserStatusDto({required this.isNewUser, this.userId});

  factory UserStatusDto.fromJson(Map<String, dynamic> json) {
    // TODO: Implement robust JSON parsing based on your API response
    // Handle potential nulls and type mismatches carefully
    return UserStatusDto(
      isNewUser: json['isNewUser'] as bool? ??
          false, // Example: default to false if null
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: Implement if you need to send this DTO to an API
    return {
      'isNewUser': isNewUser,
      'userId': userId,
    };
  }

  // Mapper to Domain Entity
  UserStatusEntity toEntity() {
    return UserStatusEntity(
      isNewUser: isNewUser,
      userId: userId,
    );
  }

  @override
  List<Object?> get props => [isNewUser, userId];
}
