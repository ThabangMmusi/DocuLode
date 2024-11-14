import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';

abstract interface class SharedRepository {
  ///get sorted modules using the user data
  Future<Either<Failure, RemoteDocModel>> getSharedFile(String id);

  ///update document
  Future<Either<Failure, void>> downloadFile({
    required String id,
    required String url,
  });
}
