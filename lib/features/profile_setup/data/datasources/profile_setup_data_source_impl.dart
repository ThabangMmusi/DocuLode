import 'dart:io';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/features/profile_setup/data/datasources/profile_setup_data_source.dart';
import 'package:doculode/features/profile_setup/domain/entities/academic_submission_entity.dart';

class ProfileSetupRemoteDataSourceImpl implements ProfileSetupDataSource {
  final DatabaseService databaseService;

  ProfileSetupRemoteDataSourceImpl({required this.databaseService});

  @override
  Future<List<CourseModel>> getAvailableCourses() async {
    return await databaseService.getAllCourses();
  }

  @override
  Future<List<ModuleModel>> getModules(
      {required String courseId,
      required int year,
      required int semester}) async {
    // Assuming DatabaseService.getSortedModules can filter by year and semester
    // You might need to adjust DatabaseService.getSortedModules or add a new method
    return await databaseService.getSingleYearModules(
        courseId: courseId, semester: semester, year: year);
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    // Assuming a bucket name like 'profile_images' and a path based on user ID or a unique ID
    // final filePath =
    // 'profile_images/${databaseService.userId}';
    // return await databaseService.uploadFile(
    //     'profile_images', filePath, imageFile); // Assuming null for XFile for now
    return "Not Implemented";
  }

  @override
  Future<void> submitRegistration(
      AcademicSubmissionEntity submission) async {
    // This will depend on how you want to store user profile data.
    // It could be an update to the existing user record or a new collection.
    // For simplicity, let's assume updating the user's profile in the 'users' table.
    await databaseService.updateUserPublicProfile({
      'course_id': submission.selectedCourseId,
      'academic_year': submission.selectedYear,
      'semester': submission.selectedSemester,
      'selected_module_ids': submission.selectedModuleIds,
    });
  }

  @override
  Future<String?> getCurrentUserName() async {
    final user = databaseService.currentUser;
    if (user != null) {
      return user.getSingleName;
    } else {
      return null;
    }
  }
}
