import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/shared_repositories.dart';
import '../source/shared_source.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedSource sharedSource;

  SharedRepositoryImpl(this.sharedSource);

  @override
  Future<Either<Failure, void>> downloadFile({
    required String id,
    required String url,
  }) async {
    try {
      final uploads = await sharedSource.downloadFile({
        'id': id,
        'url': url,
      });
      return right(uploads);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RemoteDocModel>> getSharedFile(String id) async {
    try {
      final modules = await sharedSource.getSharedFile(id);
      return modules == null ? left(Failure("File Not Found")) : right(modules);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
