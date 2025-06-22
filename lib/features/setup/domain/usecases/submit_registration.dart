import 'package:doculode/core/index.dart';
import 'package:doculode/features/setup/domain/entities/academic_submission_entity.dart';
import 'package:doculode/features/setup/data/repositories/setup_repository.dart';
import 'package:fpdart/fpdart.dart';

class SubmitRegistrationUseCase
    implements UseCase<void, AcademicSubmissionEntity> {
  final SetupRepository _repository;

  SubmitRegistrationUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AcademicSubmissionEntity params) async {
    return await _repository.submitRegistration(params);
  }
}
