import 'package:doculode/core/index.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/setup/data/repositories/setup_repository.dart';
import 'package:fpdart/fpdart.dart';

import 'package:equatable/equatable.dart';

class GetModulesParams extends Equatable {
  final String courseId;
  final int year;
  final int semester;
  const GetModulesParams({
    required this.courseId,
    required this.year,
    required this.semester,
  });
  @override
  List<Object?> get props => [courseId, year, semester];
}

class GetModulesUseCase
    implements UseCase<List<ModuleModel>, GetModulesParams> {
  final SetupRepository _repository;

  GetModulesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ModuleModel>>> call(
      GetModulesParams params) async {
    return await _repository.getModules(
        courseId: params.courseId,
        year: params.year,
        semester: params.semester);
  }
}
