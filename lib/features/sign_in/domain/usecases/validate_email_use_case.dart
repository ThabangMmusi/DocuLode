import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/validation_result.dart';

class ValidateEmailUseCase implements UseCase<ValidationResult, String> {
  @override
  Future<Either<Failure, ValidationResult>> call(String email) async {
    String errorMessage = '';

    if (email.isEmpty) {
      errorMessage = 'Email cannot be empty';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      errorMessage = 'Email must be a valid email address';
    }

    if (errorMessage.isNotEmpty) {
      return Left(ValidationFailure(errorMessage));
    }
    return Right(ValidationResult());
  }
}
