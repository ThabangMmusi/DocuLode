import 'package:fpdart/fpdart.dart';
import 'package:doculode/features/upload_progress/domain/domain.dart';

import 'package:doculode/core/core.dart';

abstract interface class UploadFileRepository {
  Stream<Either<Failure, double>> uploadFile(LocalDoc file);
}
