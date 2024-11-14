import '../../../../core/common/models/models.dart';
import '../../../../core/core.dart';
import '../../../../services/firebase/firebase_service.dart';

abstract interface class UploadEditSource {
  Future<void> updateDoc(Map<String, dynamic> file);

  ///get course modules
  Future<List<ModuleModel>> getCourseModules();
}

class UploadEditSourceImpl implements UploadEditSource {
  final FirebaseService firebaseService;

  UploadEditSourceImpl(this.firebaseService);
  @override
  Future<void> updateDoc(Map<String, dynamic> file) async {
    try {
      return await firebaseService.updateUpload(file);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ModuleModel>> getCourseModules() {
    try {
      return firebaseService.getSortedModules();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
