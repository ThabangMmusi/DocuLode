part of "upload_progress_bloc.dart";

enum UploadStatus {
  initial, //when upload for load, before any document is downloaded
  loading, // loading/fetching 20 max uploaded docs
  loaded, // done loading/fetching
  loadError, // encounter an error on database/network
  uploading, // when uploading doc
  uploaded, // done uploading file/s
  uploadError, // encounter an error on database/network
  uploadUiUpdate,
}

class UploadState extends Equatable {
  final Map<String, double> progressMap;
  final List<PickedFile> pickedFiles;
  final bool uploading;
  final ErrorMessageModel? error;
  final bool uploadComplete;
  final bool collapsed;
  final bool hide;

  const UploadState(
      {required this.progressMap,
      required this.pickedFiles,
      this.uploading = false,
      this.collapsed = false,
      this.hide = false,
      this.error,
      this.uploadComplete = false});

  UploadState copyWith(
      {Map<String, double>? progressMap,
      List<PickedFile>? pickedFiles,
      bool? uploading,
      bool? uploadComplete,
      bool? collapsed,
      bool? close,
      ErrorMessageModel? error}) {
    return UploadState(
      progressMap: progressMap ?? this.progressMap,
      pickedFiles: pickedFiles ?? this.pickedFiles,
      uploading: uploading ?? this.uploading,
      uploadComplete: uploadComplete ?? this.uploadComplete,
      error: error ?? this.error,
      collapsed: collapsed ?? this.collapsed,
      hide: close ?? this.hide,
    );
  }

  // return number of items in map
  int get itemsCount => progressMap.length;

  /// return total number completed the upload
  int get completed => progressMap.values.where((value) => value == 1.0).length;
  @override
  List<Object> get props =>
      [progressMap, pickedFiles, uploading, uploadComplete, collapsed, hide];
}
