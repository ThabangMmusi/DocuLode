import '../../../../core/core.dart';
import '../../../../services/firebase/firebase_service.dart';

abstract interface class SharedSource {
  Future<void> downloadFile(Map<String, dynamic> file);

  ///get course modules
  Future<RemoteDocModel?> getSharedFile(String id);
}

class SharedSourceImpl implements SharedSource {
  final FirebaseService firebaseService;

  SharedSourceImpl(this.firebaseService);
  @override
  Future<void> downloadFile(Map<String, dynamic> file) async {
    try {
      return await firebaseService.downloadFile(file);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RemoteDocModel?> getSharedFile(String id) {
    try {
      return firebaseService.getUploadedFile(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
