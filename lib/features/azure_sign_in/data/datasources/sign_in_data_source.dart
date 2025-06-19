// Assuming UserStatusDto is defined, e.g., in lib/features/auth/data/models/user_status_dto.dart
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/error/exceptions.dart'; // Adjust path

abstract class SignInDataSource {
  Future<void> signInWithMicrosoftApi();
  Future<bool> isUserLoggedIn();
}

class SignInDataSourceImpl implements SignInDataSource {
  final DatabaseService _databaseService;

  SignInDataSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      return _databaseService.isUserLoggedIn();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signInWithMicrosoftApi() async {
    try {
      await _databaseService.signInWithMicrosoft();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
