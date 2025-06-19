import 'package:doculode/core/commands/files/pick_file_command.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doculode/features/upload_progress/domain/domain.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/features/uploads/presentation/bloc/uploads_bloc.dart';
part 'upload_progress_event.dart';
part 'upload_progress_state.dart';

class UploadProgressBloc extends Bloc<UploadEvent, UploadState> {
  final UploadFile _uploadFile;
  final UploadsBloc _uploadsBloc;

  UploadProgressBloc(UploadFile uploadFile, UploadsBloc uploadsBloc)
      : _uploadFile = uploadFile,
        _uploadsBloc = uploadsBloc,
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
    _uploadsBloc.add(event);
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
