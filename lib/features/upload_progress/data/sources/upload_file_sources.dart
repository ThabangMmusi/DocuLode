import 'dart:async';
import 'package:doculode/core/domain/repositories/database_service.dart';

import '../../../../core/core.dart';
import '../model/local_doc_model.dart';

abstract interface class UploadFileSource {
  Stream<double> uploadFile(LocalDocModel file);
}

class UploadFileSourceImpl implements UploadFileSource {
  final DatabaseService _databaseService;

  UploadFileSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;
  @override
  Stream<double> uploadFile(LocalDocModel file) async* {
    try {
      yield* _databaseService.uploadFile(file.name, file.path, file.asset);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
