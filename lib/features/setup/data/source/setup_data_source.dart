import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../core/common/models/src/course_model/course_model.dart';
import '../../../../core/common/models/src/module_model/module_model.dart';

abstract interface class SetupDataSource {
  ///get courses
  Future<List<CourseModel>> getAllCourses();

  ///get course modules
  Future<List<ModuleModel>> getCourseModules({
    required int maxLevel,
    required List<ModuleModel> modules,
  });

  /// add modules to user info
  Future<void> uploadUserEducation({
    required List<String> modules,
    required int level,
    required String courseId,
  });
}

class SetupDataSourceImpl implements SetupDataSource {
  final FirebaseService firebaseService = serviceLocator<FirebaseService>();
  @override
  Future<List<CourseModel>> getAllCourses() {
    try {
      return firebaseService.getAllCourses();
    } catch (e) {
      print("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ModuleModel>> getCourseModules(
      {required int maxLevel, required List<ModuleModel> modules}) {
    try {
      return firebaseService.getSortedModules(
        maxLevel: maxLevel,
        modules: modules,
      );
    } catch (e) {
      print("courses from firebase: $e");
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
