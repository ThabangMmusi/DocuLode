import 'dart:async';

import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../core/core.dart';
import '../model/local_doc_model.dart';

abstract interface class UploadFileSource {
  Stream<double> uploadFile(LocalDocModel file);
}

class UploadFileSourceImpl implements UploadFileSource {
  final FirebaseService firebaseService;
  UploadFileSourceImpl(this.firebaseService);
  @override
  Stream<double> uploadFile(LocalDocModel file) async* {
    try {
      yield* firebaseService.uploadFile(file.name, file.path, file.asset);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
