import 'package:fpdart/fpdart.dart';

import 'package:doculode/core/core.dart';

abstract interface class UploadsRepository {
  ///update document
  Future<Either<Failure, double>> deleteDoc(RemoteDoc file);

  ///load limited document with pagination
  Future<Either<Failure, FetchedRemoteDocs>> getUploads();
}
