import 'package:doculode/core/domain/repositories/database_service.dart';

import '../../../../core/core.dart';
import 'package:doculode/services/services.dart';

abstract interface class SharedSource {
  Future<void> downloadFile(Map<String, dynamic> file);

  ///get course modules
  Future<RemoteDocModel?> getSharedFile(String id);
}

class SharedSourceImpl implements SharedSource {
  final DatabaseService _databaseService;
  SharedSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;
  @override
  Future<void> downloadFile(Map<String, dynamic> file) async {
    try {
      return await _databaseService.downloadFile(file);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RemoteDocModel?> getSharedFile(String id) {
    try {
      return _databaseService.getUploadedFile(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
