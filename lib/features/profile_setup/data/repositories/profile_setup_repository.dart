import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/profile_setup/domain/entities/academic_submission_entity.dart';

abstract class ProfileSetupRepository {
  Future<Either<Failure, List<CourseModel>>> getAvailableCourses();
  Future<Either<Failure, List<ModuleModel>>> getModules({required String courseId, required int year, required int semester});
  Future<Either<Failure, String>> uploadProfileImage(File imageFile);
  Future<Either<Failure, Unit>> submitRegistration(AcademicSubmissionEntity submission);
  Future<Either<Failure, String?>> getCurrentUserName();
}