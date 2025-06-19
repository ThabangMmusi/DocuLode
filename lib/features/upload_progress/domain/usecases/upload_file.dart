import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/features/upload_progress/domain/domain.dart';
import 'package:doculode/core/core.dart';

class UploadFile {
  final UploadFileRepository uploadFileRepository;

  UploadFile(this.uploadFileRepository);

  Stream<Either<Failure, double>> upload(LocalDoc file) async* {
    file.asset;
    yield* uploadFileRepository.uploadFile(file);
  }
}

class UploadFileParams {
  final String? path;
  final String name;
  final XFile? asset;

  UploadFileParams({
    required this.path,
    required this.name,
    required this.asset,
  });
}
