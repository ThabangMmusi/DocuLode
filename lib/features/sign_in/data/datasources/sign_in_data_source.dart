// Assuming UserStatusDto is defined, e.g., in lib/features/auth/data/models/user_status_dto.dart
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/error/exceptions.dart'; // Adjust path

abstract class SignInDataSource {
  /// Sends an OTP request to the backend.
  /// Throws a [ServerException] for all error codes.
  Future<void> requestOtpApi(String email);

  /// Verifies the OTP with the backend and retrieves user status.
  /// Throws a [ServerException] for server errors or [InvalidOtpException] for incorrect OTP.
  Future<void> verifyOtpApi(String email, String otp);

  /// Resends an OTP request to the backend.
  /// Throws a [ServerException] for all error codes.
  Future<void> resendOtpApi(String email);
  Future<bool> isUserLoggedIn();
}

class SignInDataSourceImpl implements SignInDataSource {
  final DatabaseService _databaseService;

  SignInDataSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<void> requestOtpApi(String email) {
    try {
      return _databaseService.requestOtpWithEmail(email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resendOtpApi(String email) {
    return requestOtpApi(email);
  }

  @override
  @override
  Future<bool> isUserLoggedIn() async {
    try {
      return _databaseService.isUserLoggedIn();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> verifyOtpApi(String email, String otp) {
    try {
      return _databaseService.verifyEmailOtp(email, otp);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
