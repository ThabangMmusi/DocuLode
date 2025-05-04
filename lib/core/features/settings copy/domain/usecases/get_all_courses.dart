import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';

import '../../../../domain/entities/course.dart';
import '../repositories/base_settings_repositories.dart';

class GetAllCourses implements UseCase<List<Course>, NoParams> {
  final BaseSettingsRepository _setUpRepository;

  GetAllCourses(this._setUpRepository);

  @override
  Future<Either<Failure, List<Course>>> call(NoParams params) async {
    return await _setUpRepository.getAllCourses();
  }
}
