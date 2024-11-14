// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'uploads_bloc.dart';

abstract class UploadsEvent {}

class FetchDocuments extends UploadsEvent {}

class UpdateDocuments extends UploadsEvent {
  final List<RemoteDocModel> files;
  UpdateDocuments(this.files);
}

class UpdateEditDone extends UploadsEvent {
  final RemoteDocModel file;
  UpdateEditDone(this.file);
}

class NewUploadsDone extends UploadsEvent {
  final List<RemoteDocModel> files;
  NewUploadsDone(this.files);
}
