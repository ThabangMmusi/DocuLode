import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';


import '../../../../domain/entities/course.dart';
import '../repositories/base_settings_repository.dart';

class GetAllCoursesUsecase implements UseCase<List<Course>, NoParams> {
  final BaseSettingsRepository _setUpRepository;

  GetAllCoursesUsecase(this._setUpRepository);

  @override
  Future<Either<Failure, List<Course>>> call(NoParams params) async {
    return await _setUpRepository.getAllCourses();
  }
}
