import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../data/models/models.dart';

abstract interface class BaseSettingsDataSource {
  ///get courses
  Future<List<CourseModel>> getAllCourses();

  ///get course modules
  Future<List<ModuleModel>> getCourseModules({
    required int maxLevel,
    required String courseId,
  });

  /// add modules to user info
  Future<void> uploadUserEducation({
    required List<String> modules,
    required int level,
    required String courseId,
  });
}

class BaseSettingsDataSourceImpl implements BaseSettingsDataSource {
  final FirebaseService firebaseService = serviceLocator<FirebaseService>();
  @override
  Future<List<CourseModel>> getAllCourses() {
    try {
      return firebaseService.getAllCourses();
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ModuleModel>> getCourseModules(
      {required int maxLevel, required String courseId}) {
    try {
      return firebaseService.getSortedModules(
        maxLevel: maxLevel,
       courseId: courseId,
      );
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> uploadUserEducation({
    required List<String> modules,
    required int level,
    required String courseId,
  }) {
    try {
      return firebaseService.updateUser({
        FireIds.modules: modules,
        FireIds.level: level,
        FireIds.course: courseId,
      });
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }
}
