import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';

import '../../../../domain/entities/module.dart';
import '../repositories/base_settings_repositories.dart';

class GetCourseModules implements UseCase<List<Module>, CourseModulesParams> {
  final BaseSettingsRepository _setUpRepository;

  GetCourseModules(this._setUpRepository);

  @override
  Future<Either<Failure, List<Module>>> call(CourseModulesParams params) async {
    return await _setUpRepository.getCourseModules(
      maxLevel: params.maxLevel,
      courseId: params.courseId,
    );
  }
}

class CourseModulesParams {
  final int maxLevel;
  final String courseId;

  CourseModulesParams({
    required this.maxLevel,
    required this.courseId,
  });
}
