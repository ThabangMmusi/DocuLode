import 'package:fpdart/fpdart.dart';
import 'package:its_shared/features/upload_edit/data/source/upload_edit_source.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/upload_edit_repositories.dart';

class UploadEditRepositoryImpl implements UploadEditRepository {
  final UploadEditSource uploadEditSource;

  UploadEditRepositoryImpl(this.uploadEditSource);

  @override
  Future<Either<Failure, void>> updateDoc({
    required String id,
    required String name,
    required List<int> types,
    required List<String> modules,
  }) async {
    try {
      final uploads = await uploadEditSource.updateDoc({
        'id': id,
        'name': name,
        'type': types,
        'modules': modules,
      });
      return right(uploads);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
