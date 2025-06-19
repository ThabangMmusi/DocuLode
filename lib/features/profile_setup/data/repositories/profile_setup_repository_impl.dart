import 'dart:io';
import 'package:doculode/features/profile_setup/domain/entities/academic_submission_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/profile_setup/data/datasources/profile_setup_data_source.dart';
import 'package:doculode/features/profile_setup/data/repositories/profile_setup_repository.dart';

class ProfileSetupRepositoryImpl implements ProfileSetupRepository {
  final ProfileSetupDataSource dataSource;

  ProfileSetupRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<CourseModel>>> getAvailableCourses() async {
    try {
      final courses = await dataSource.getAvailableCourses();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModuleModel>>> getModules({required String courseId, required int year, required int semester}) async {
    try {
      final modules = await dataSource.getModules(courseId: courseId, year: year, semester: semester);
      return Right(modules);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(File imageFile) async {
    try {
      final imageUrl = await dataSource.uploadProfileImage(imageFile);
      return Right(imageUrl);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitRegistration(AcademicSubmissionEntity submission) async {
    try {
      await dataSource.submitRegistration(submission);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String?>> getCurrentUserName() async {
    try {
      final userName = await dataSource.getCurrentUserName();
      return Right(userName);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}