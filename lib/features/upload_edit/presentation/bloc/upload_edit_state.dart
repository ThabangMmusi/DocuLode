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
    required this.semester,
    this.year = 2,
    this.id = "",
    this.ext = "",
    this.name = "",
    this.types = const [],
    this.modules = const [],
  });

  final UploadEditStatus status;
  final String id;
  final String ext;
  final String name;
  final List<int> types;
  final Set<int> semester;
  final int year;
  final List<String> modules;

  UploadEditState copyWith({
    UploadEditStatus? status,
    String? id,
    String? ext,
    String? name,
    List<int>? types,
    Set<int>? semester,
    int? year,
    List<String>? modules,
  }) {
    return UploadEditState(
      status: status ?? this.status,
      semester: semester ?? this.semester,
      year: year ?? this.year,
      id: id ?? this.id,
      ext: ext ?? this.ext,
      name: name ?? this.name,
      types: types ?? this.types,
      modules: modules ?? this.modules,
    );
  }

  @override
  List<Object?> get props => [status, id, name, types, modules];
}
