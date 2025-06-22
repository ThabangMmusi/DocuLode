import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/index.dart';



















import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../app/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/domain/entities/entities.dart';
import '../../../../core/data/models/models.dart';
import '../../domain/usecases/get_shared_file.dart';
import '../../domain/usecases/download_file.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final DownloadFile _downloadFile = sl<DownloadFile>();
  final GetSharedFile _getSharedFile = sl<GetSharedFile>();
  final AuthBloc _authBloc = sl<AuthBloc>();

  SharedBloc() : super(const SharedState()) {
    on<SharedViewStart>(_onStart);
    on<SharedDownload>(_onDownloadFile);
    on<SharedShowFile>(_onShowFile);
    on<UploadEditNameChanged>(_onNameChanged);
    on<UploadEditTypesChanged>(_onTypesChanged);
  }

  void _loading(Emitter<SharedState> emit) {
    emit(state.copyWith(status: SharedStatus.loading));
  }

  void _onNameChanged(
    UploadEditNameChanged event,
    Emitter<SharedState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onDownloadFile(
      SharedDownload event, Emitter<SharedState> emit) async {
    final res =
        await _downloadFile(DownloadFileParams(id: state.id, url: state.url));

    res.fold(
      (l) => emit(state.copyWith(
        error: ErrorMessageModel(error: l.message),
        status: SharedStatus.failure,
        modules: null,
        url: null,
        id: state.id,
        ext: null,
        type: null,
        name: null,
        access: null,
      )),
      (r) {
        emit(state);
      },
    );
  }

  void _onTypesChanged(
    UploadEditTypesChanged event,
    Emitter<SharedState> emit,
  ) {
    emit(state.copyWith(type: event.type));
  }

  Future<void> _onStart(
      SharedViewStart event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: SharedStatus.initial));
    final res = await _getSharedFile(event.id);

    res.fold(
      (l) => emit(state.copyWith(
        error: ErrorMessageModel(error: l.message),
        status: SharedStatus.failure,
        modules: null,
        url: null,
        id: event.id,
        ext: null,
        type: null,
        name: null,
        access: null,
      )),
      (r) {
        emit(state.copyWith(
          status: SharedStatus.loaded,
          modules: r.modules,
          url: r.url,
          id: r.id,
          ext: r.ext,
          type: r.type,
          name: r.onlyName,
          access: r.access,
          owners: _authBloc.state.user?.id == r.uid,
        ));
      },
    );
  }

  Future<void> _onShowFile(
      SharedShowFile event, Emitter<SharedState> emit) async {
    final r = event.f;
    emit(state.copyWith(
      status: SharedStatus.loaded,
      modules: r.modules,
      url: r.url,
      id: r.id,
      ext: r.ext,
      type: r.type,
      name: r.onlyName,
      access: r.access,
      owners: _authBloc.state.user?.id == r.uid,
    ));
  }
}
