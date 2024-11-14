part of 'upload_edit_bloc.dart';

enum UploadEditStatus { initial, loading, loaded, success, failure }

extension EditFileStatusX on UploadEditStatus {
  bool get isLoadingOrSuccess => [
        UploadEditStatus.loading,
        UploadEditStatus.success,
      ].contains(this);
}

final class UploadEditState extends Equatable {
  const UploadEditState({
    this.status = UploadEditStatus.initial,
    this.id = "",
    this.ext = "",
    this.name = "",
    this.access = AccessType.unpublished,
    this.type,
    this.modules = const [],
    this.selectedModules = const [],
  });

  final UploadEditStatus status;
  final String id;
  final String ext;
  final String name;
  final AccessType access;
  final UploadCategory? type;
  final List<Module> modules;
  final List<Module> selectedModules;

  UploadEditState copyWith({
    UploadEditStatus? status,
    String? id,
    String? ext,
    String? name,
    AccessType? access,
    UploadCategory? type,
    int? year,
    List<Module>? selectedModules,
    List<Module>? modules,
  }) {
    return UploadEditState(
      id: id ?? this.id,
      ext: ext ?? this.ext,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      access: access ?? this.access,
      modules: modules ?? this.modules,
      selectedModules: selectedModules ?? this.selectedModules,
    );
  }

  String get fileFullName => '$name.$ext';
  @override
  List<Object?> get props => [
        id,
        ext,
        name,
        type,
        status,
        access,
        modules,
        selectedModules,
      ];
}
