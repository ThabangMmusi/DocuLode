import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';

import '../entities/entities.dart';
import '../repositories/user_repository.dart';

class GetCurrentUser implements UseCase<AuthUser?, NoParams> {
  final UserRepository _repository;

  const GetCurrentUser(this._repository);

  @override
  Future<Either<Failure, AuthUser?>> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}
