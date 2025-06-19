import 'package:doculode/core/domain/repositories/database_service.dart';

import '../../../../core/data/models/models.dart';
import '../../../../core/core.dart';
import 'package:doculode/services/services.dart';

abstract interface class UploadEditSource {
  Future<void> updateDoc(Map<String, dynamic> file);

  ///get course modules
  Future<List<ModuleModel>> getCourseModules();
}

class UploadEditSourceImpl implements UploadEditSource {
  final DatabaseService _databaseService;

  UploadEditSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<void> updateDoc(Map<String, dynamic> file) async {
    try {
      return await _databaseService.updateUpload(file);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ModuleModel>> getCourseModules() {
    try {
      return _databaseService.getMultipleYearsModules();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
