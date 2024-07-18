part of "upload_progress_bloc.dart";

// abstract class UploadEvent extends Equatable {
//   const UploadEvent();

//   @override
//   List<Object> get props => [];
// }

// class UploadProgress extends UploadEvent {
//   final int index;
//   final double progress;

//   const UploadProgress(this.index, this.progress);

//   @override
//   List<Object> get props => [index, progress];
// }

// class UploadFiles extends UploadEvent {
//   final List<PickedFile> files;

//   const UploadFiles(this.files);

//   @override
//   List<Object> get props => [files];
// }

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadingFiles extends UploadEvent {
  final List<PickedFile> files;

  const UploadingFiles(this.files);

  @override
  List<Object> get props => [files];
}

class UpdateUploadProgress extends UploadEvent {
  final String filePath;
  final double progress;

  const UpdateUploadProgress(this.filePath, this.progress);

  @override
  List<Object> get props => [filePath, progress];
}

class UploadingError extends UploadEvent {
  final ErrorMessageModel error;

  const UploadingError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadStarted extends UploadEvent {
  final List<PickedFile> files;

  const UploadStarted(this.files);

  @override
  List<Object> get props => [files];
}

class UploadComplete extends UploadEvent {
  const UploadComplete();

  @override
  List<Object> get props => [];
}

class UpdateUploadUi extends UploadEvent {
  final bool collapsed;
  final bool close;

  const UpdateUploadUi({this.close = false, this.collapsed = false});

  @override
  List<Object> get props => [collapsed];
}

class FetchDocuments extends UploadEvent {}
