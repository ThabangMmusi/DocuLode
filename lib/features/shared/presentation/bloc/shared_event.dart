part of 'shared_bloc.dart';

sealed class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object> get props => [];
}

final class UploadEditNameChanged extends SharedEvent {
  const UploadEditNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UploadEditTypesChanged extends SharedEvent {
  const UploadEditTypesChanged(this.type);

  final UploadCategory type;

  @override
  List<Object> get props => [type];
}

final class SharedDownload extends SharedEvent {
  const SharedDownload();
}

final class SharedShowFile extends SharedEvent {
  final RemoteDocModel f;
  const SharedShowFile(this.f);
}

final class SharedViewStart extends SharedEvent {
  final String id;
  const SharedViewStart(this.id);
  @override
  List<Object> get props => [id];
}

final class UploadEditSemesterChanged extends SharedEvent {
  const UploadEditSemesterChanged(this.semester);

  final Set<int> semester;

  @override
  List<Object> get props => [semester];
}

final class UploadEditSelectModule extends SharedEvent {
  final Module module;

  const UploadEditSelectModule(this.module);

  @override
  List<Object> get props => [module];
}
