import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';


import '../../../../domain/entities/module.dart';
import '../repositories/base_settings_repository.dart';

class GetCourseModulesUsecase implements UseCase<List<Module>, CourseModulesParams> {
  final BaseSettingsRepository _setUpRepository;

  GetCourseModulesUsecase(this._setUpRepository);

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
