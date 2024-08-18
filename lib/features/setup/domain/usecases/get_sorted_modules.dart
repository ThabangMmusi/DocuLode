import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../entities/module.dart';
import '../repositories/setup_repositories.dart';

class GetSortedModules implements UseCase<List<Module>, SortedModulesParams> {
  final SetUpRepository _setUpRepository = serviceLocator<SetUpRepository>();

  @override
  Future<Either<Failure, List<Module>>> call(SortedModulesParams params) async {
    return await _setUpRepository.getSortedModules(
      maxLevel: params.maxLevel,
      courseId: params.courseId,
    );
  }
}

class SortedModulesParams {
  final int maxLevel;
  final String courseId;

  SortedModulesParams({
    required this.maxLevel,
    required this.courseId,
  });
}
