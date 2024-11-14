import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/setup/data/source/setup_data_source.dart';
import 'package:its_shared/core/common/entities/src/course.dart';
import 'package:its_shared/core/common/entities/src/module.dart';
import 'package:its_shared/features/setup/domain/repositories/setup_repositories.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/models/models.dart';

class SetupRepositoriesImpl implements SetUpRepository {
  final SetupDataSource _dataSource = serviceLocator<SetupDataSource>();
  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    try {
      final courses = await _dataSource.getAllCourses();
      return right(courses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Module>>> getCourseModules(
      {required int maxLevel, required List<Module> modules}) async {
    try {
      final mods = modules
          .map((m) => ModuleModel(id: m.id, level: m.level, name: m.name))
          .toList();
      return right(await _dataSource.getCourseModules(
          maxLevel: maxLevel, modules: mods));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> uploadUserEducation({
    required List<Module> modules,
    required int level,
    required String courseId,
  }) async {
    try {
      await _dataSource.uploadUserEducation(
        modules: modules.map((item) => item.id).toList(),
        level: level,
        courseId: courseId,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
