import 'dart:io';

import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/setup/domain/entities/academic_submission_entity.dart';

abstract class SetupDataSource {
  Future<List<CourseModel>> getAvailableCourses();
  Future<List<ModuleModel>> getModules({required String courseId, required int year, required int semester});
  Future<String> uploadImage(File imageFile);
  Future<void> submitRegistration(AcademicSubmissionEntity submission);

}