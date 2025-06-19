import 'package:doculode/core/data/converters/index.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/domain/entities/auth_user.dart';
import 'package:doculode/core/data/models/models.dart';

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

  /// Update user profile information
  Future<void> updateUserProfile({
    required String names,
    required String surname,
  });

  /// Sign out user (mirrors AuthDataSource)
  Future<void> signOut();
}

class BaseSettingsDataSourceImpl implements BaseSettingsDataSource {
  final DatabaseService _firebaseService;

  BaseSettingsDataSourceImpl({required DatabaseService firebaseService})
      : _firebaseService = firebaseService;

  DatabaseService get firebaseService => _firebaseService;

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
      return _firebaseService.getMultipleYearsModules(
        endYear: maxLevel,
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
      return _firebaseService.updateUserEducationProfile(
        selectedModuleIds: modules,
        level: level,
        courseId: courseId,
      );
    } catch (e) {
      log("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateUserProfile({
    required String names,
    required String surname,
  }) {
    try {
      return _firebaseService.updateUserPublicProfile({
        'names': names,
        'surname': surname,
      });
    } catch (e) {
      log("Update profile error: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      log("Sign out error: $e");
      throw ServerException(e.toString());
    }
  }
}
