import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/setup/data/source/setup_data_source.dart';
import 'package:its_shared/features/setup/domain/entities/course.dart';
import 'package:its_shared/features/setup/domain/entities/module.dart';
import 'package:its_shared/features/setup/domain/repositories/setup_repositories.dart';
import 'package:its_shared/injection_container.dart';

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
  Future<Either<Failure, List<Module>>> getSortedModules(
      {required int maxLevel, required String courseId}) async {
    try {
      final modules = await _dataSource.getSortedModules(
          maxLevel: maxLevel, courseId: courseId);
      return right(modules);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> uploadUserModules(
      {required List<String> moduleIds}) {
    // TODO: implement uploadUserModules
    throw UnimplementedError();
  }
}
