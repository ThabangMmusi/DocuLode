import '../entities/validation_result.dart';

class ValidatePasswordUseCase {
  ValidationResult call(String password) {
    if (password.isEmpty) {
      return ValidationResult(errorMessage: 'Password cannot be empty.');
    }
    if (password.length < 8) {
      return ValidationResult(
          errorMessage: 'Password must be at least 8 characters.');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return ValidationResult(
          errorMessage: 'Password must contain an uppercase letter.');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return ValidationResult(
          errorMessage: 'Password must contain a lowercase letter.');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return ValidationResult(errorMessage: 'Password must contain a number.');
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return ValidationResult(
          errorMessage: 'Password must contain a special character.');
    }
    // Add more complexity rules if needed
    return ValidationResult(errorMessage: "");
  }
}
