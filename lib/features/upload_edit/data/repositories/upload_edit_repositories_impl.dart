import 'package:fpdart/fpdart.dart';
import 'package:doculode/core/domain/entities/module.dart';
import 'package:doculode/features/upload_edit/data/source/upload_edit_source.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/upload_edit_repositories.dart';

class UploadEditRepositoryImpl implements UploadEditRepository {
  final UploadEditSource uploadEditSource;

  UploadEditRepositoryImpl(this.uploadEditSource);

  @override
  Future<Either<Failure, void>> updateDoc({
    required String id,
    required String name,
    required int access,
    required int type,
    required List<String> modules,
  }) async {
    try {
      final uploads = await uploadEditSource.updateDoc({
        'id': id,
        'name': name,
        'type': type,
        'modules': modules,
        'access': access,
      });
      return right(uploads);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Module>>> getSortedModules() async {
    try {
      final modules = await uploadEditSource.getCourseModules();
      return right(modules);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
