// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "upload_progress_bloc.dart";

// abstract class UploadState extends Equatable {
//   const UploadState();

//   @override
//   List<Object> get props => [];
// }

// class UploadInitial extends UploadState {}

// class UploadInProgress extends UploadState {
//   final int index;
//   final double progress;

//   const UploadInProgress(this.index, this.progress);

//   @override
//   List<Object> get props => [index, progress];
// }

// class UploadSuccess extends UploadState {
//   final List<String> downloadUrls;

//   const UploadSuccess(this.downloadUrls);

//   @override
//   List<Object> get props => [downloadUrls];
// }

// class UploadFailure extends UploadState {
//   final String error;

//   const UploadFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

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

// class UploadState extends Equatable {
//   final UploadStatus status;
//   final Map<String, double>? progressMap;
//   final List<PickedFile>? pickedFiles;
//   final ErrorMessageModel? error;
//   final bool
//       uploadClose, // hide and clear upload progress of newly uploaded files
//       uploadCollapsed; // collapse the upload progress ui

//   const UploadState._({
//     this.status = UploadStatus.initial,
//     this.progressMap,
//     this.pickedFiles,
//     this.error,
//     this.uploadCollapsed = false,
//     this.uploadClose = false,
//   });

//   // return number of items in map
//   int get itemsCount => progressMap!.length;

//   /// return total number completed the upload
//   int get completed =>
//       progressMap!.values.where((value) => value == 1.0).length;

//   UploadState.initial() : this._(pickedFiles: [], progressMap: {});

//   const UploadState.uploading({required Map<String, double> progressMap})
//       : this._(
//             status: UploadStatus.uploading,
//             progressMap: progressMap,
//             uploadClose: false,
//             uploadCollapsed: false);

//   const UploadState.uploadComplete() : this._(status: UploadStatus.uploaded);
//   const UploadState.uploadError({required ErrorMessageModel error})
//       : this._(status: UploadStatus.uploadError, error: error);

//   const UploadState.uploadUiUpdate(
//       {required bool uploadClose, required bool uploadCollapsed})
//       : this._(
//           status: UploadStatus.uploadUiUpdate,
//           uploadClose: uploadClose,
//           uploadCollapsed: uploadCollapsed,
//         );
//   // const UploadState.uploadUiClose()
//   //     : this._(
//   //         status: UploadStatus.uploadUiUpdate,
//   //         uploadClose: uploadClose,
//   //         uploadCollapsed: uploadCollapsed,
//   //       );

//   UploadState copyWith(
//       {required UploadStatus status,
//       Map<String, double>? progressMap,
//       List<PickedFile>? pickedFiles,
//       bool? uploadCollapse,
//       bool? uploadClose,
//       ErrorMessageModel? error}) {
//     return UploadState._(
//       status: status,
//       progressMap: progressMap ?? this.progressMap,
//       pickedFiles: pickedFiles ?? this.pickedFiles,
//       // uploading: uploading ?? this.uploading,
//       // uploadComplete: uploadComplete ?? this.uploadComplete,
//       error: error ?? this.error,
//       uploadCollapsed: uploadCollapse ?? this.uploadCollapsed,
//       uploadClose: uploadClose ?? this.uploadClose,
//     );
//   }

//   // UploadState copyWith(
//   //     {Map<String, double>? progressMap,
//   //     UploadStatus? status,
//   //     ErrorMessageModel? error}) {
//   //   return UploadState(
//   //       progressMap: progressMap ?? this.progressMap,
//   //       status: status ?? this.status,
//   //       error: error ?? this.error);
//   // }

//   @override
//   List<Object> get props => [status];
// }
