import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../features/sign_in/domain/entities/validation_result.dart';

class ValidateNameUseCase implements UseCase<ValidationResult, String> {
  @override
  Future<Either<Failure, ValidationResult>> call(String name) async {
    final trimmedName = name.trim();
    String errorMessage = "";
    if (trimmedName.isEmpty) {
      errorMessage = 'Name cannot be empty';
    } else if (trimmedName.length < 2) {
      errorMessage = 'Name must be at least 2 characters';
    } else if (trimmedName.length > 50) {
      errorMessage = 'Name cannot exceed 50 characters';
    } else if (!RegExp(r"^[a-zA-Z\s\-']+").hasMatch(trimmedName)) {
      errorMessage =
          'Name can only contain letters, spaces, hyphens and apostrophes';
    }
    if (errorMessage.isNotEmpty) {
      return left(ValidationFailure(errorMessage));
    } else {
      return right(ValidationResult(
        errorMessage: "",
      ));
    }
  }
}
