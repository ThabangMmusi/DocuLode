import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';

abstract interface class UploadEditRepository {
  ///update document
  Future<Either<Failure, void>> updateDoc({
    required String id,
    required String name,
    required List<int> types,
    required List<String> modules,
  });
}
