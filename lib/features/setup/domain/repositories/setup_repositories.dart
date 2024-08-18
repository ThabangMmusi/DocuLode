import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/error/failures.dart';
import 'package:its_shared/features/setup/domain/entities/course.dart';
import 'package:its_shared/features/setup/domain/entities/module.dart';

abstract interface class SetUpRepository {
  ///get courses
  Future<Either<Failure, List<Course>>> getAllCourses();

  ///get course modules
  Future<Either<Failure, List<Module>>> getSortedModules({
    required int maxLevel,
    required String courseId,
  });

  /// add modules to user info
  Future<Either<Failure, void>> uploadUserModules({
    required List<String> moduleIds,
  });
}
