import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/validation_result.dart';

class ValidateOTPUseCase implements UseCase<ValidationResult, String> {
  @override
  Future<Either<Failure, ValidationResult>> call(String otp) async {
    final trimmedOTP = otp.trim();
    String errorMessage = "";
    if (trimmedOTP.isEmpty) {
      errorMessage = 'OTP cannot be empty';
    } else if (trimmedOTP.length < 6) {
      errorMessage = 'OTP must be 6 digits';
    } else if (trimmedOTP.length > 6) {
      errorMessage = 'OTP cannot exceed 6 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(trimmedOTP)) {
      errorMessage = 'OTP can only contain numbers';
    }
    if (errorMessage.isNotEmpty) {
      return left(ValidationFailure(errorMessage));
    } else {
      return right(ValidationResult());
    }
  }
}
