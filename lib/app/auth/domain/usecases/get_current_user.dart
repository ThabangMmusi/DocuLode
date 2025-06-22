import 'package:doculode/app/auth/domain/repositories/auth_repository.dart';
import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/entities/entities.dart';

class GetCurrentUser implements UseCase<AppUser?, NoParams> {
  final AuthRepository _repository;


  const GetCurrentUser(this._repository);

  @override
  Future<Either<Failure, AppUser?>> call(NoParams params) async {
    return right(null);// await _repository.getCurrentUser();
  }
}
