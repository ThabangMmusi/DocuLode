import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/entities/src/module.dart';
import '../repositories/setup_repositories.dart';

class UpdateUser implements UseCase<void, UpdateUserModulesParams> {
  final SetUpRepository _setUpRepository = serviceLocator<SetUpRepository>();

  @override
  Future<Either<Failure, void>> call(UpdateUserModulesParams params) async {
    return await _setUpRepository.uploadUserEducation(
      modules: params.modules,
      level: params.level,
      courseId: params.courseId,
    );
  }
}

class UpdateUserModulesParams {
  final List<Module> modules;
  final int level;
  final String courseId;

  UpdateUserModulesParams({
    required this.modules,
    required this.courseId,
    required this.level,
  });
}
