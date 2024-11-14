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
      final files = await firebaseService.getUserUploads();
      List<RemoteDocModel> finalFiles = [];
      for (RemoteDocModel file in files.docs!) {
        final modules = await firebaseService.getModuleNames(file.modules);
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
    //   yield * firebaseService.uploadFile(file.name, file.path, file.asset);
    // } catch (e) {
    // throw ServerException(e.toString());
    // }
    throw const ServerException("No method yet");
  }
}
