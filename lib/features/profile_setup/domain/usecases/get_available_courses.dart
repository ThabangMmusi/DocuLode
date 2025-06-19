import 'package:doculode/core/index.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/profile_setup/data/repositories/profile_setup_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAvailableCoursesUseCase
    implements UseCase<List<CourseModel>, NoParams> {
  final ProfileSetupRepository repository;

  GetAvailableCoursesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CourseModel>>> call(NoParams params) async {
    return await repository.getAvailableCourses();
  }
}
