import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/entities.dart';
import '../../../../core/core.dart';

abstract interface class UploadEditRepository {
  ///get sorted modules using the user data
  Future<Either<Failure, List<Module>>> getSortedModules();

  ///update document
  Future<Either<Failure, void>> updateDoc({
    required String id,
    required String name,
    required int access,
    required int type,
    required List<String> modules,
  });
}
