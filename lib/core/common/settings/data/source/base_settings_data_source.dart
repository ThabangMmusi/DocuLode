import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/data/converters/converters.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../data/models/models.dart';

abstract interface class BaseSettingsDataSource {
  Future<AuthUser?> getCurrentUser();

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
  final FirebaseService _firebaseService;

  BaseSettingsDataSourceImpl({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  FirebaseService get firebaseService => _firebaseService;

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseService.currentUser;
      if (firebaseUser == null) return null;
      return firebaseUser.toEntity();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getAllCourses() {
    try {
      return _firebaseService.getAllCourses();
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ModuleModel>> getCourseModules(
      {required int maxLevel, required String courseId}) {
    try {
      return _firebaseService.getSortedModules(
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
      return _firebaseService.updateUserEducation(
        modules: modules,
        level: level,
        courseId: courseId,
      );
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }
}
