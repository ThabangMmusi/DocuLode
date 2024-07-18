import 'package:fpdart/fpdart.dart';
import 'package:its_shared/features/upload_progress/domain/domain.dart';

import '../../../../core/core.dart';

abstract interface class UploadFileRepository {
  Stream<Either<Failure, double>> uploadFile(LocalDoc file);
}
