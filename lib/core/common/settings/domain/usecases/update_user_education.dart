import 'package:doculode/core/index.dart';
import 'package:doculode/core/domain/entities/module.dart';

import 'package:fpdart/fpdart.dart';

import '../repositories/base_settings_repository.dart';

class UpdateUserEdu implements UseCase<void, UpdateUserEduParams> {
  final BaseSettingsRepository _setUpRepository;

  UpdateUserEdu(this._setUpRepository);

  @override
  Future<Either<Failure, void>> call(UpdateUserEduParams params) =>
      _setUpRepository.uploadUserEducation(
        modules: params.modules,
        level: params.level,
        courseId: params.courseId,
      );
}

class UpdateUserEduParams {
  final List<Module> modules;
  final int level;
  final String courseId;

  const UpdateUserEduParams({
    required this.modules,
    required this.courseId,
    required this.level,
  });
}
