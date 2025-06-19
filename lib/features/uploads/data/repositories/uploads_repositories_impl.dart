import 'package:fpdart/fpdart.dart';
import 'package:doculode/features/uploads/data/source/uploads_source.dart';
import 'package:doculode/core/core.dart';
import 'package:doculode/features/uploads/domain/repositories/uploads_repositories.dart';

class UploadsRepositoryImpl implements UploadsRepository {
  final UploadsSource uploadsSource;

  UploadsRepositoryImpl(this.uploadsSource);
  @override
  Future<Either<Failure, FetchedRemoteDocs>> getUploads() async {
    try {
      final uploads = await uploadsSource.getUploads();
      return right(uploads);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, double>> deleteDoc(RemoteDoc file) {
    // TODO: implement updateDoc
    throw UnimplementedError();
  }
}
