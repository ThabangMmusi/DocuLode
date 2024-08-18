part of 'upload_edit_bloc.dart';

sealed class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

final class UploadEditNameChanged extends EditTodoEvent {
  const UploadEditNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UploadEditTypesChanged extends EditTodoEvent {
  const UploadEditTypesChanged(this.types);

  final List<int> types;

  @override
  List<Object> get props => [types];
}

final class UploadEditModulesChanged extends EditTodoEvent {
  const UploadEditModulesChanged(this.modules);

  final List<String> modules;

  @override
  List<Object> get props => [modules];
}

final class UploadEditSubmitted extends EditTodoEvent {
  const UploadEditSubmitted();
}

final class UploadEditLoaded extends EditTodoEvent {
  final RemoteDocModel doc;
  const UploadEditLoaded(this.doc);
}

final class UploadEditSemesterChanged extends EditTodoEvent {
  const UploadEditSemesterChanged(this.semester);

  final Set<int> semester;

  @override
  List<Object> get props => [semester];
}
