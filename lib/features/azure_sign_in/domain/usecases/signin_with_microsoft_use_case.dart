import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:doculode/features/azure_sign_in/domain/repositories/sign_in_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInWithMicrosoftUseCase implements UseCase<void, NoParams> {
  final SignInRepository _repository;

  SignInWithMicrosoftUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.signInWithMicrosoft();
  }
}