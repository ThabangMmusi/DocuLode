import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/features/upload_progress/domain/domain.dart';
import 'package:its_shared/features/upload_progress/domain/usecases/upload_file.dart';

import '../../../../commands/files/pick_file_command.dart';
import '../../../../models/models.dart';
import '../../../../services/firebase/firebase_service.dart';
part 'upload_progress_event.dart';
part 'upload_progress_state.dart';

// class UploadBloc extends Bloc<UploadEvent, UploadState> {
//   UploadBloc() : super(UploadInitial());

//   Stream<UploadState> mapEventToState(UploadEvent event) async* {
//     if (event is UploadFiles) {
//       yield* _mapUploadFilesToState(event);
//     }
//   }

//   Stream<UploadState> _mapUploadFilesToState(UploadFiles event) async* {
//     List<String> downloadUrls = [];
//     final storageRef = FirebaseStorage.instance.ref();
//     final auth = FirebaseAuth.instance;

//     try {
//       for (int i = 0; i < event.files.length; i++) {
//         final file = event.files[i];
//         var data = await file.asset?.readAsBytes();
//         final uploadTask =
//             storageRef.child('uploads/${auth.userId}').putData(data!);

//         uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//           double progress = snapshot.bytesTransferred / snapshot.totalBytes;
//           add(UploadProgress(i, progress));
//         });

//         final snapshot = await uploadTask;
//         final downloadUrl = await snapshot.ref.getDownloadURL();
//         downloadUrls.add(downloadUrl);
//       }

//       yield UploadSuccess(downloadUrls);
//     } catch (e) {
//       yield UploadFailure(e.toString());
//     }
//   }
// }

class UploadProgressBloc extends Bloc<UploadEvent, UploadState> {
  final UploadFile _uploadFile;

  UploadProgressBloc(UploadFile uploadFile)
      : _uploadFile = uploadFile,
        super(const UploadState(progressMap: {}, pickedFiles: [])) {
    on<UploadingFiles>(_onUploadFiles);
    on<UpdateUploadProgress>(_onUpdateUploadProgress);
    on<UploadingError>(_onUploadingError);
    on<UploadComplete>(_onUploadComplete);
    on<UpdateUploadUi>(_onUpdateUploadUi);
  }

  void _onUpdateUploadUi(UpdateUploadUi event, emit) {
    // clear  lists on close
    bool clear = event.close == true;
    UploadState newState =
        state.copyWith(collapsed: event.collapsed, close: event.close);
    if (clear) newState.copyWith(pickedFiles: [], progressMap: {});
    emit(newState);
  }

  void _onUploadingError(UploadingError event, emit) {
    emit(state.copyWith(error: event.error));
  }

  Future<void> _onUploadFiles(
      UploadingFiles event, Emitter<UploadState> emit) async {
    //todo:: add newly selected items to the list without uploading them again
    final List<PickedFile> files = [];
    //add files previously uploaded
    //NB: if lis was never cleared
    for (var file in state.pickedFiles) {
      files.add(file);
    }
    //add newly added filed to be uploaded
    for (var file in event.files) {
      files.add(file);
    }
    emit(state.copyWith(pickedFiles: files));
    for (var file in event.files) {
      _uploadingFile(file, emit);
    }
  }

  void _onUploadComplete(event, emit) {
    emit(state.copyWith(uploadComplete: true));
  }

  void _onUpdateUploadProgress(
      UpdateUploadProgress event, Emitter<UploadState> emit) {
    final newProgressMap = Map<String, double>.from(state.progressMap);
    newProgressMap[event.filePath] = event.progress;
    final complete = state.completed == newProgressMap.length;
    emit(state.copyWith(
        progressMap: newProgressMap,
        uploading: true,
        collapsed: false,
        close: false,
        uploadComplete: complete));
  }

  void _uploadingFile(PickedFile file, Emitter<UploadState> emit) async {
    // final storage = FirebaseStorage.instance;
    // var data = await file.asset?.readAsBytes();
    // final uploadTask = storage
    //     .ref('uploads/${_authRepository.currentUser!.uid!}/${file.name}')
    //     .putData(data!);

    // uploadTask.snapshotEvents.listen((event) {
    //   final progress = event.bytesTransferred / event.totalBytes;
    //   add(UpdateUploadProgress(file.name, progress));
    //   log("${file.name} : $progress");
    // }).onError((error) {
    //   // Handle error
    //   add(UploadingError(
    //       error: ErrorMessageModel(error: error, title: file.name)));
    //   return;
    // });

    // await uploadTask;
    LocalDoc params =
        LocalDoc(path: file.path, name: file.name, asset: file.asset);
    _uploadFile.upload(params).listen((event) {
      event.fold(
          (error) => add(UploadingError(
              error:
                  ErrorMessageModel(error: error.message, title: file.name))),
          (progress) => add(UpdateUploadProgress(file.name, progress)));
    });
  }
}

//
// class UploadBloc extends Bloc<UploadEvent, UploadState> {
//   final FirebaseService _authRepository;

//   UploadBloc({
//     required FirebaseService authRepository,
//   })  : _authRepository = authRepository,
//         super(const UploadState(progressMap: {})) {
//     on<UploadFiles>(_onUploadFiles);
//     on<UpdateUploadProgress>(_onUpdateUploadProgress);
//     on<UploadingError>(_onUploadingError);
//   }

//   void _onUploadingError(event, emit) {
//     emit(state.copyWith(status: UploadStatus.hasError, error: event.error));
//   }

//   Future<void> _onUploadFiles(
//       UploadFiles event, Emitter<UploadState> emit) async {
//     for (var file in event.files) {
//       _uploadFile(file, emit);
//     }
//     emit(state.copyWith(
//         status: UploadStatus.doneUploading, progressMap: state.progressMap!));
//   }

//   void _onUpdateUploadProgress(
//       UpdateUploadProgress event, Emitter<UploadState> emit) {
//     final newProgressMap = Map<String, double>.from(state.progressMap);
//     newProgressMap[event.filePath] = event.progress;
//     emit(state.copyWith(
//         status: UploadStatus.uploading, progressMap: newProgressMap));
//   }

//   Future<void> _uploadFile(PickedFile file, Emitter<UploadState> emit) async {
//     final storage = FirebaseStorage.instance;
//     var data = await file.asset?.readAsBytes();
//     final uploadTask = storage
//         .ref('uploads/${_authRepository.currentUser!.uid!}/${file.name}')
//         .putData(data!);

//     uploadTask.snapshotEvents.listen((event) {
//       final progress = event.bytesTransferred / event.totalBytes;
//       add(UpdateUploadProgress(file.name, progress));
//       log("${file.name} : $progress");
//     }).onError((error) {
//       // Handle error
//       add(UploadingError(
//           error: ErrorMessageModel(error: error, title: file.name)));
//       return;
//     });

//     await uploadTask;
//   }
// }
