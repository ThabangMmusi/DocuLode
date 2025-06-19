import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/usecase/usecase.dart';
import 'package:doculode/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoggedInUseCase implements UseCase<bool, NoParams> {
  final SignInRepository _repository;

  UserLoggedInUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _repository.isUserLoggedIn();
  }
}