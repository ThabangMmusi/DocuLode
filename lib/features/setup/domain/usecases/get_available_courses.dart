import 'package:doculode/core/index.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/setup/data/repositories/setup_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAvailableCoursesUseCase
    implements UseCase<List<CourseModel>, NoParams> {
  final SetupRepository _repository;

  GetAvailableCoursesUseCase(this._repository);

  @override
  Future<Either<Failure, List<CourseModel>>> call(NoParams params) async {
    return await _repository.getAvailableCourses();
  }
}
