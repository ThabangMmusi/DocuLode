import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/error/failures.dart';
import 'package:its_shared/core/common/entities/src/course.dart';
import 'package:its_shared/core/common/entities/src/module.dart';

abstract interface class SetUpRepository {
  ///get courses
  Future<Either<Failure, List<Course>>> getAllCourses();

  ///get sorted modules
  Future<Either<Failure, List<Module>>> getCourseModules({
    required int maxLevel,
    required List<Module> modules,
  });

  /// add modules to user info
  Future<Either<Failure, void>> uploadUserEducation({
    required List<Module> modules,
    required int level,
    required String courseId,
  });
}
