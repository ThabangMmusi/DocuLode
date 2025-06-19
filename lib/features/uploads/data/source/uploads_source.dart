import 'package:doculode/core/domain/repositories/database_service.dart';

import 'package:doculode/core/core.dart';

abstract interface class UploadsSource {
  Future<FetchedRemoteDocs> getUploads();

  Future<String> deleteDoc(RemoteDocModel file);
}

class UploadsSourceImpl implements UploadsSource {
  final DatabaseService _databaseService;

  UploadsSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<FetchedRemoteDocs> getUploads() async {
    try {
      final files = await _databaseService.getUserUploads();
      List<RemoteDocModel> finalFiles = [];
      for (RemoteDocModel file in files.docs!) {
        final modules = await _databaseService
            .getModulesByIds(file.modules!.map((e) => e.id).toList());
        finalFiles.add(file.copyWith(modules: modules));
      }
      return FetchedRemoteDocs(docs: finalFiles);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> deleteDoc(RemoteDocModel file) {
    // try {
    //   yield * databaseService.uploadFile(file.name, file.path, file.asset);
    // } catch (e) {
    // throw ServerException(e.toString());
    // }
    throw const ServerException("No method yet");
  }
}
