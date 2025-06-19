import 'package:doculode/core/error/failures.dart';
import 'package:fpdart/fpdart.dart'; // Adjust path

abstract class SignInRepository {
  // Sends an OTP to the email
  Future<Either<Failure, void>> requestOtp(String email);

  // Verifies the OTP and then checks if the user is new or existing
Future<Either<Failure, void>> verifyOtp(
      {required String email, required String otp});

  // Resends an OTP
  Future<Either<Failure, void>> resendOtp(String email);

  Future<Either<Failure, bool>> isUserLoggedIn();
}
