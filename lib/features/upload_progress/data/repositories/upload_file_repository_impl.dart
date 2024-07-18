import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/upload_progress/data/model/local_doc_model.dart';

import '../../../../_utils/logger.dart';
import '../../domain/domain.dart';
import '../sources/upload_file_sources.dart';

class UploadFileRepositoryImpl implements UploadFileRepository {
  final UploadFileSource uploadFileSources;

  UploadFileRepositoryImpl(this.uploadFileSources);

  @override
  Stream<Either<Failure, double>> uploadFile(LocalDoc file) async* {
    try {
      LocalDocModel fileModel = LocalDocModel(
        name: file.name,
        asset: file.asset,
        path: file.path,
      );
      // double progress = 0;
      await for (var progress in uploadFileSources.uploadFile(fileModel)) {
        // double progress = event.bytesTransferred / event.totalBytes;
        log("UploadFileRepositoryImpl: ${file.name} : $progress");
        // yield progress;
        yield right(progress);
      }
      // uploadFileSources.uploadFile(fileModel).listen((event) {
      //   print(event);
      //   progress = event;
      // });

      // yield right(progress);
    } on ServerException catch (e) {
      yield left(Failure(e.message));
    }
  }
}
