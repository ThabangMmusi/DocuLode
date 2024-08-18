import '../../../../core/core.dart';
import '../../../../services/firebase/firebase_service.dart';

abstract interface class UploadsSource {
  Future<FetchedRemoteDocs> getUploads();

  Future<String> deleteDoc(RemoteDocModel file);
}

class UploadsSourceImpl implements UploadsSource {
  final FirebaseService firebaseService;
  UploadsSourceImpl(this.firebaseService);

  @override
  Future<FetchedRemoteDocs> getUploads() async {
    try {
      return await firebaseService.getUserUploads();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> deleteDoc(RemoteDocModel file) {
    // try {
    //   yield * firebaseService.uploadFile(file.name, file.path, file.asset);
    // } catch (e) {
    // throw ServerException(e.toString());
    // }
    throw const ServerException("No method yet");
  }
}
