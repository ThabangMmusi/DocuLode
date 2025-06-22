import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';


import '../../../../domain/entities/entities.dart';
import '../../domain/repositories/base_settings_repository.dart';
import '../source/base_settings_data_source.dart';

class BaseSettingsRepositoryImpl implements BaseSettingsRepository {
  final BaseSettingsDataSource _dataSource;

  BaseSettingsDataSource get dataSource => _dataSource;
  BaseSettingsRepositoryImpl({required BaseSettingsDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      return right(await _dataSource.getCurrentUser());
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    try {
      final courses = await _dataSource.getAllCourses();
      return right(courses);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Module>>> getCourseModules(
      {required int maxLevel, required String courseId}) async {
    try {
      return right(await _dataSource.getCourseModules(
          maxLevel: maxLevel, courseId: courseId));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> uploadUserEducation({
    required List<Module> modules,
    required int level,
    required String courseId,
  }) async {
    try {
      await _dataSource.uploadUserEducation(
        modules: modules.map((item) => item.id).toList(),
        level: level,
        courseId: courseId,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required String names,
    required String surname,
  }) async {
    try {
      await _dataSource.updateUserProfile(
        names: names,
        surname: surname,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
