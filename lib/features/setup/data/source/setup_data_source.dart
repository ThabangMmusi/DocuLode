import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../models/course_model/course_model.dart';
import '../models/module_model/module_model.dart';

abstract interface class SetupDataSource {
  ///get courses
  Future<List<CourseModel>> getAllCourses();

  ///get course modules
  Future<List<ModuleModel>> getSortedModules({
    required int maxLevel,
    required String courseId,
  });

  /// add modules to user info
  Future<void> uploadUserModules({
    required List<String> moduleIds,
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
  Future<List<ModuleModel>> getSortedModules(
      {required int maxLevel, required String courseId}) {
    try {
      return firebaseService.getSortedModules(
        maxLevel: maxLevel,
        courseId: courseId,
      );
    } catch (e) {
      print("courses from firebase: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> uploadUserModules({required List<String> moduleIds}) {
    // TODO: implement uploadUserModules
    throw UnimplementedError();
  }
}
