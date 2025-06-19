import 'package:doculode/core/index.dart';
import 'package:doculode/features/profile_setup/data/repositories/profile_setup_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserNameUseCase implements UseCase<String?, NoParams> {
  final ProfileSetupRepository _repository;

  GetUserNameUseCase(this._repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await _repository.getCurrentUserName();
  }
}