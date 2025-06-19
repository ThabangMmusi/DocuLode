import 'package:doculode/core/index.dart';
import 'package:doculode/features/profile_setup/domain/entities/academic_submission_entity.dart';
import 'package:doculode/features/profile_setup/data/repositories/profile_setup_repository.dart';
import 'package:fpdart/fpdart.dart';

class SubmitRegistrationUseCase
    implements UseCase<void, AcademicSubmissionEntity> {
  final ProfileSetupRepository repository;

  SubmitRegistrationUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(AcademicSubmissionEntity params) async {
    return await repository.submitRegistration(params);
  }
}
