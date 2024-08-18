import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/setup/domain/usecases/get_all_courses.dart';
import 'package:its_shared/features/setup/domain/usecases/get_sorted_modules.dart';
import 'package:its_shared/injection_container.dart';

import '../../domain/entities/course.dart';
import '../../domain/entities/module.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final GetAllCourses _getAllCourses = serviceLocator<GetAllCourses>();
  final GetSortedModules _getSortedModules = serviceLocator<GetSortedModules>();
  SetupBloc() : super(const SetupState()) {
    // on<SetupEvent>(_loading);
    on<SetupCourseSelect>(_onCourseSelect);
    on<SetupModulesSelectedChange>(_onModulesSelectedChange);
    on<SetupGetAllCourses>(_onGetAllCourses);
    on<SetupGetSortedModules>(_onGetSortedModules);
    on<SetupLevelChange>(_onLevelChange);
  }

  void _loading(Emitter<SetupState> emit) {
    emit(state.copyWith(status: SetupStatus.loading));
  }

  void _onCourseSelect(SetupCourseSelect event, Emitter<SetupState> emit) {
    emit(state.copyWith(selectedCourse: event.selectedCourse));
  }

  void _onLevelChange(SetupLevelChange event, Emitter<SetupState> emit) {
    if (state.userLevel != event.level) {
      emit(state.copyWith(userLevel: event.level));
    }
  }

  void _onModulesSelectedChange(
      SetupModulesSelectedChange event, Emitter<SetupState> emit) {
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

  Future<void> _onGetAllCourses(
    SetupGetAllCourses event,
    Emitter<SetupState> emit,
  ) async {
    _loading(emit);
    final res = await _getAllCourses(NoParams());

    res.fold(
      (l) => emit(
        state.copyWith(status: SetupStatus.failure, errorMessage: l.message),
      ),
      (r) => emit(state.copyWith(status: SetupStatus.success, courses: r)),
    );
  }

  Future<void> _onGetSortedModules(
    SetupGetSortedModules event,
    Emitter<SetupState> emit,
  ) async {
    _loading(emit);
    final res = await _getSortedModules(SortedModulesParams(
      courseId: state.selectedCourse!.id!,
      maxLevel: state.userLevel!,
    ));

    res.fold(
      (l) => emit(
        state.copyWith(status: SetupStatus.failure, errorMessage: l.message),
      ),
      (r) {
        final selected = r
            .where(
              (element) => element.level == state.userLevel!,
            )
            .toList();
        emit(state.copyWith(
            status: SetupStatus.success,
            modules: r,
            selectedModules: selected));
      },
    );
  }
}
