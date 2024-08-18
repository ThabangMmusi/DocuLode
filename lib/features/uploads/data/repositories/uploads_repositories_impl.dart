import 'package:fpdart/fpdart.dart';
import 'package:its_shared/features/uploads/data/source/uploads_source.dart';
import '../../../../core/core.dart';
import '../../domain/repositories/uploads_repositories.dart';

class UploadsRepositoryImpl implements UploadsRepository {
  final UploadsSource uploadsSource;

  UploadsRepositoryImpl(this.uploadsSource);
  @override
  Future<Either<Failure, FetchedRemoteDocs>> getUploads() async {
    try {
      final uploads = await uploadsSource.getUploads();
      return right(uploads);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, double>> deleteDoc(RemoteDoc file) {
    // TODO: implement updateDoc
    throw UnimplementedError();
  }
}
