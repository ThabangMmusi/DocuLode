import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/setup/domain/entities/academic_submission_entity.dart';

abstract class SetupRepository {
  Future<Either<Failure, List<CourseModel>>> getAvailableCourses();
  Future<Either<Failure, List<ModuleModel>>> getModules({required String courseId, required int year, required int semester});
  Future<Either<Failure, String>> uploadImage(File imageFile);
  Future<Either<Failure, Unit>> submitRegistration(AcademicSubmissionEntity submission);
}