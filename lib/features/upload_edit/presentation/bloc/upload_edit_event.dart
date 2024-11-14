part of 'upload_edit_bloc.dart';

sealed class UploadEditEvent extends Equatable {
  const UploadEditEvent();

  @override
  List<Object> get props => [];
}

final class UploadEditNameChanged extends UploadEditEvent {
  const UploadEditNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UploadEditTypesChanged extends UploadEditEvent {
  const UploadEditTypesChanged(this.type);

  final UploadCategory type;

  @override
  List<Object> get props => [type];
}

final class UploadEditSubmit extends UploadEditEvent {
  const UploadEditSubmit();
}

final class UploadEditStart extends UploadEditEvent {
  final RemoteDocModel doc;
  const UploadEditStart(this.doc);
  @override
  List<Object> get props => [doc];
}

final class UploadEditSemesterChanged extends UploadEditEvent {
  const UploadEditSemesterChanged(this.semester);

  final Set<int> semester;

  @override
  List<Object> get props => [semester];
}

final class UploadEditSelectModule extends UploadEditEvent {
  final Module module;

  const UploadEditSelectModule(this.module);

  @override
  List<Object> get props => [module];
}
