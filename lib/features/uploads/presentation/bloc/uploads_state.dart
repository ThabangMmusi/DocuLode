part of 'uploads_bloc.dart';

abstract class UploadsState {}

class DocumentsInitial extends UploadsState {}

class DocumentsLoading extends UploadsState {}

class DocumentsLoaded extends UploadsState {
  final List<RemoteDocModel> documents;
  final bool hasMore;

  DocumentsLoaded(this.documents, this.hasMore);
}

class DocumentsError extends UploadsState {
  final String message;

  DocumentsError(this.message);
}
