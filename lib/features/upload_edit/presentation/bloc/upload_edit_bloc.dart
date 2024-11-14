import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/entities/entities.dart';
import '../../domain/usecases/get_sorted_modules.dart';
import '../../domain/usecases/update_file.dart';

part 'upload_edit_event.dart';
part 'upload_edit_state.dart';

class UploadEditBloc extends Bloc<UploadEditEvent, UploadEditState> {
  final UploadUpdate _uploadUpdate = serviceLocator<UploadUpdate>();
  final GetSortedModules _getSortedModules = serviceLocator<GetSortedModules>();
  // final UploadsBloc _uploadsBloc = serviceLocator<UploadsBloc>();

  UploadEditBloc() : super(const UploadEditState()) {
    on<UploadEditStart>(_onStart);
    on<UploadEditNameChanged>(_onNameChanged);
    on<UploadEditTypesChanged>(_onTypesChanged);
    on<UploadEditSelectModule>(_onModulesSelectedChange);
    on<UploadEditSubmit>(_onSubmitted);
  }

  void _loading(Emitter<UploadEditState> emit) {
    emit(state.copyWith(status: UploadEditStatus.loading));
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
    emit(state.copyWith(type: event.type));
  }

  void _onModulesSelectedChange(
    UploadEditSelectModule event,
    Emitter<UploadEditState> emit,
  ) {
    bool isSelected = false;
    if (state.selectedModules.isNotEmpty) {
      isSelected = state.selectedModules.contains(event.module);
    }

    // Create a new list from the current selectedModules list
    final modules = List<Module>.from(state.selectedModules);
    if (isSelected) {
      modules.remove(event.module);
    } else {
      modules.add(event.module);
    }
    emit(state.copyWith(selectedModules: modules));
  }

  Future<void> _onSubmitted(
    UploadEditSubmit event,
    Emitter<UploadEditState> emit,
  ) async {
    emit(state.copyWith(status: UploadEditStatus.loading));

    final res = await _uploadUpdate(UpdateFileParams(
      id: state.id,
      name: state.fileFullName,
      type: state.type!.asInt,
      access: state.access.asInt == 0 ? 2 : state.access.asInt,
      modules: state.selectedModules.map((e) => e.id).toList(),
    ));
    res.fold((error) => emit(state.copyWith(status: UploadEditStatus.failure)),
        (success) {
      emit(state.copyWith(status: UploadEditStatus.success));
      // _uploadsBloc.add(UpdateDocuments(files: [
      //   RemoteDocModel(
      //     id: state.id,
      //     name: state.fileFullName,
      //     type: state.type,
      //     access: state.access.asInt == 0 ? AccessType.public : state.access,
      //     modules: state.modules.map((e) => ModuleModel.fromModule(e)).toList(),
      //     url: "",
      //     uploaded: DateTime.now(),
      //     uid: "",
      //     size: "",
      //   )
      // ]));

      // _uploadsBloc.add(FetchDocuments());
    });
  }

  Future<void> _onStart(
      UploadEditStart event, Emitter<UploadEditState> emit) async {
    emit(state.copyWith(status: UploadEditStatus.initial));
    final res = await _getSortedModules(NoParams());

    res.fold(
      (l) => log(l.message),
      (r) {
        final doc = event.doc;
        List<Module> selectedModules = [];

        // for (var i = 0; i < doc.modules.length; i++) {
        //   selectedModules.append(r.firstWhere((e) => e.id == doc.modules[i]));
        // }
        Map<String?, Module> originalMap = {
          for (var model in r) model.id: model
        };
        for (var newModel in doc.modules!) {
          if (originalMap.containsKey(newModel.id)) {
            int index = r.indexWhere((model) => model.id == newModel.id);
            selectedModules.add(r[index]);
          }
        }
        emit(state.copyWith(
          status: UploadEditStatus.loaded,
          modules: r,
          selectedModules: selectedModules,
          id: doc.id,
          ext: doc.ext,
          type: doc.type,
          name: doc.onlyName,
          access: doc.access,
        ));
      },
    );
  }
}
