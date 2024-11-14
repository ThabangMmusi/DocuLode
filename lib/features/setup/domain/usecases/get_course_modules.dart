import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/entities/entities.dart';
import '../repositories/setup_repositories.dart';

class GetCourseModules implements UseCase<List<Module>, CourseModulesParams> {
  final SetUpRepository _setUpRepository = serviceLocator<SetUpRepository>();

  @override
  Future<Either<Failure, List<Module>>> call(CourseModulesParams params) async {
    return await _setUpRepository.getCourseModules(
      maxLevel: params.maxLevel,
      modules: params.modules,
    );
  }
}

class CourseModulesParams {
  final int maxLevel;
  final List<Module> modules;

  CourseModulesParams({
    required this.maxLevel,
    required this.modules,
  });
}
