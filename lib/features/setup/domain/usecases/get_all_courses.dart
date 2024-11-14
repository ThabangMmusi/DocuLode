import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/entities/src/course.dart';
import '../repositories/setup_repositories.dart';

class GetAllCourses implements UseCase<List<Course>, NoParams> {
  final SetUpRepository _setUpRepository = serviceLocator<SetUpRepository>();

  @override
  Future<Either<Failure, List<Course>>> call(NoParams params) async {
    return await _setUpRepository.getAllCourses();
  }
}
