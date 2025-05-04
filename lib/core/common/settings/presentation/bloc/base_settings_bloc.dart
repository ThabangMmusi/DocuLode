import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/core/core.dart';

import '../../../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'base_settings_event.dart';
part 'base_settings_state.dart';

class BaseSettingsBloc<T extends BaseSettingsState>
    extends Bloc<BaseSettingsEvent, T> {
  final GetAllCourses _getAllCourses;
  final GetCourseModules _getSortedModules;
  final UpdateUserEdu _updateUserEdu;

  GetAllCourses get getAllCourses => _getAllCourses;
  GetCourseModules get getSortedModules => _getSortedModules;

  BaseSettingsBloc({
    required GetAllCourses getAllCourses,
    required GetCourseModules getSortedModules,
    required UpdateUserEdu updateUserEdu,
    required T initialState,
  })  : 
        _getAllCourses = getAllCourses,
        _getSortedModules = getSortedModules,
        _updateUserEdu = updateUserEdu,
        super(initialState) {
    on<SelectCourseEvent>(_onCourseSelect);
    on<SelectModuleEvent>(_onModuleSelect);
    on<GetAllCoursesEvent>(onGetAllCourses);
    on<GetSortedModulesEvent>(_onGetSortedModules);
    on<SelectLevelEvent>(_onLevelChange);
    on<UpdateUserEduEvent>(_onUpdateUserEdu);
    on<LoadingEvent>(_loading);
  }

  void _loading(LoadingEvent event, Emitter<T> emit) =>
      emit(state.copyWith(status: SettingsStatus.loadingCourses) as T);

  void error(Emitter<T> emit, String message) => emit(
      state.copyWith(status: SettingsStatus.error, errorMsg: message) as T);

  void _onCourseSelect(SelectCourseEvent event, Emitter<T> emit) {
    if (state.selectedCourse == event.selectedCourse) return;
    emit(state.copyWith(selectedCourse: event.selectedCourse) as T);
  }

  void _onLevelChange(SelectLevelEvent event, Emitter<T> emit) {
    if (state.selectedLevel == event.level) return;
    emit(state.copyWith(selectedLevel: event.level) as T);
    add(GetSortedModulesEvent());
  }

  void _onModuleSelect(SelectModuleEvent event, Emitter<T> emit) {
    final modules = List<Module>.from(state.selectedModules);
    state.selectedModules.contains(event.module)
        ? modules.remove(event.module)
        : modules.add(event.module);
    emit(state.copyWith(selectedModules: modules) as T);
  }

  Future<void> onGetAllCourses(
    GetAllCoursesEvent event,
    Emitter<T> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loadingCourses) as T);
    final res = await _getAllCourses(NoParams());
    res.fold(
      (l) => error(emit, l.message),
      (r) =>
          emit(state.copyWith(status: SettingsStatus.success, courses: r) as T),
    );
  }

  Future<void> _onGetSortedModules(
    GetSortedModulesEvent event,
    Emitter<T> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loadingModules) as T);
    final res = await _getSortedModules(CourseModulesParams(
      courseId: state.selectedCourse!.id,
      maxLevel: state.selectedLevel,
    ));

    res.fold(
      (l) => error(emit, l.message),
      (r) {
        final selected =
            r.where((e) => e.level == state.selectedLevel).toList();
        emit(state.copyWith(
          status: SettingsStatus.success,
          modules: r,
          selectedModules: selected,
        ) as T);
      },
    );
  }

  Future<void> _onUpdateUserEdu(
    UpdateUserEduEvent event,
    Emitter<T> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.finalizing) as T);
    final res = await _updateUserEdu(UpdateUserEduParams(
      modules: state.selectedModules,
      level: state.selectedLevel,
      courseId: state.selectedCourse!.id,
    ));

    res.fold(
      (l) => error(emit, l.message),
      (r) {
        emit(state.copyWith(status: SettingsStatus.done) as T);
      },
    );
  }
}
