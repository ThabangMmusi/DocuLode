part of 'shared_bloc.dart';

enum SharedStatus { initial, loading, loaded, success, failure }

extension EditFileStatusX on SharedStatus {
  bool get isLoadingOrSuccess => [
        SharedStatus.loading,
        SharedStatus.success,
      ].contains(this);
}

final class SharedState extends Equatable {
  const SharedState({
    this.status = SharedStatus.initial,
    this.id = "",
    this.ext = "",
    this.name = "",
    this.access = AccessType.unpublished,
    this.type,
    this.modules = const [],
    this.url = "",
    this.error,
    this.owners = false,
  });

  final SharedStatus status;
  final String id;
  final String ext;
  final String name;
  final AccessType access;
  final UploadCategory? type;
  final List<Module> modules;
  final String url;
  final ErrorMessageModel? error;
  final bool owners;

  SharedState copyWith({
    SharedStatus? status,
    String? id,
    String? ext,
    String? name,
    AccessType? access,
    UploadCategory? type,
    int? year,
    String? url,
    List<Module>? modules,
    ErrorMessageModel? error,
    bool? owners,
  }) {
    return SharedState(
      id: id ?? this.id,
      ext: ext ?? this.ext,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      access: access ?? this.access,
      modules: modules ?? this.modules,
      url: url ?? this.url,
      error: error ?? this.error,
      owners: owners ?? this.owners,
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
        url,
      ];
}
