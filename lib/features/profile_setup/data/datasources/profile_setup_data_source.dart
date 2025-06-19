import 'dart:io';

import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/profile_setup/domain/entities/academic_submission_entity.dart';

abstract class ProfileSetupDataSource {
  Future<List<CourseModel>> getAvailableCourses();
  Future<List<ModuleModel>> getModules({required String courseId, required int year, required int semester});
  Future<String> uploadProfileImage(File imageFile);
  Future<void> submitRegistration(AcademicSubmissionEntity submission);
  Future<String?> getCurrentUserName();
}