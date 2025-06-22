import 'package:doculode/core/domain/entities/entities.dart';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/error/failures.dart';

abstract interface class BaseSettingsRepository {
  ///get courses
  Future<Either<Failure, List<Course>>> getAllCourses();

  ///get sorted modules
  Future<Either<Failure, List<Module>>> getCourseModules({
    required int maxLevel,
    required String courseId,
  });

  /// add modules to user info
  Future<Either<Failure, void>> uploadUserEducation({
    required List<Module> modules,
    required int level,
    required String courseId,
  });

  /// Sign out user (mirrors AuthRepository)
  Future<Either<Failure, void>> signOut();

  /// Update user profile information
  Future<Either<Failure, void>> updateUserProfile({
    required String names,
    required String surname,
  });
}
