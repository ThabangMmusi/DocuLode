import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';

import '../repositories/auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final AuthRepository _repository;

  SignOut({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.signOut();
  }
}
