import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/core/core.dart';

import '../../domain/usecases/update_file.dart';

part 'upload_edit_event.dart';
part 'upload_edit_state.dart';

class UploadEditBloc extends Bloc<EditTodoEvent, UploadEditState> {
  final UploadEdit _uploadFile;
  UploadEditBloc({
    required UploadEdit uploadFile,
  })  : _uploadFile = uploadFile,
        super(const UploadEditState(semester: {1})) {
    on<UploadEditLoaded>(_onLoaded);
    on<UploadEditNameChanged>(_onNameChanged);
    on<UploadEditTypesChanged>(_onTypesChanged);
    on<UploadEditModulesChanged>(_onModulesChanged);
    on<UploadEditSubmitted>(_onSubmitted);
  }

  void _onNameChanged(
    UploadEditNameChanged event,
    Emitter<UploadEditState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onTypesChanged(
    UploadEditTypesChanged event,
    Emitter<UploadEditState> emit,
  ) {
    emit(state.copyWith(types: event.types));
  }

  void _onModulesChanged(
    UploadEditModulesChanged event,
    Emitter<UploadEditState> emit,
  ) {
    emit(state.copyWith(modules: event.modules));
  }

  Future<void> _onSubmitted(
    UploadEditSubmitted event,
    Emitter<UploadEditState> emit,
  ) async {
    emit(state.copyWith(status: UploadEditStatus.loading));

    final res = await _uploadFile(UpdateFileParams(
      id: state.id,
      name: state.name,
      types: state.types,
      modules: state.modules,
    ));
    res.fold((error) => emit(state.copyWith(status: UploadEditStatus.failure)),
        (success) => emit(state.copyWith(status: UploadEditStatus.success)));
  }

  void _onLoaded(UploadEditLoaded event, Emitter<UploadEditState> emit) {
    emit(state.copyWith(
        id: event.doc.id,
        name: event.doc.onlyName,
        ext: event.doc.ext,
        types: event.doc.types,
        modules: event.doc.modules,
        status: UploadEditStatus.loaded));
  }
}
