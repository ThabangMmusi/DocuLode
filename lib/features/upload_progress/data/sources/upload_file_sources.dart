import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../core/core.dart';
import '../model/local_doc_model.dart';

abstract interface class UploadFileSource {
  Stream<double> uploadFile(LocalDocModel file);
}

class UploadFileSourceImpl implements UploadFileSource {
  final FirebaseStorage storage;
  final FirebaseService firebaseService;
  UploadFileSourceImpl(this.storage, this.firebaseService);
  @override
  Stream<double> uploadFile(LocalDocModel file) async* {
    try {
      var data = await file.asset?.readAsBytes();
      final uploadTask = storage
          .ref('uploads/${firebaseService.currentUid!}/${file.name}')
          .putData(data!);
      await for (var event in uploadTask.snapshotEvents) {
        double progress = event.bytesTransferred / event.totalBytes;
        log("${file.name} : $progress");
        yield progress;
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
