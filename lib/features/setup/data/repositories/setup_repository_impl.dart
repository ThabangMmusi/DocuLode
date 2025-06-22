import 'dart:io';
import 'package:doculode/features/setup/domain/entities/academic_submission_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/setup/data/datasources/setup_data_source.dart';
import 'package:doculode/features/setup/data/repositories/setup_repository.dart';

class SetupRepositoryImpl implements SetupRepository {
  final SetupDataSource _dataSource;

  SetupRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<CourseModel>>> getAvailableCourses() async {
    try {
      final courses = await _dataSource.getAvailableCourses();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ModuleModel>>> getModules({required String courseId, required int year, required int semester}) async {
    try {
      final modules = await _dataSource.getModules(courseId: courseId, year: year, semester: semester);
      return Right(modules);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File imageFile) async {
    try {
      final imageUrl = await _dataSource.uploadImage(imageFile);
      return Right(imageUrl);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitRegistration(AcademicSubmissionEntity submission) async {
    try {
      await _dataSource.submitRegistration(submission);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}