import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/core/bloc/auth/auth_bloc.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/common/entities/src/course.dart';
import '../../../../core/common/entities/src/module.dart';
import '../../../../core/common/models/models.dart';
import '../../domain/usecases/setup_usecases.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final GetAllCourses _getAllCourses = serviceLocator<GetAllCourses>();
  final GetCourseModules _getSortedModules = serviceLocator<GetCourseModules>();
  final UpdateUser _updateUser = serviceLocator<UpdateUser>();
  final AuthBloc _authBloc = serviceLocator<AuthBloc>();
  SetupBloc() : super(const SetupState()) {
    // on<SetupEvent>(_loading);
    on<SetupCourseSelect>(_onCourseSelect);
    on<SetupSelectedModule>(_onModulesSelectedChange);
    on<SetupGetAllCourses>(_onGetAllCourses);
    on<SetupGetSortedModules>(_onGetSortedModules);
    on<SetupLevelChange>(_onLevelChange);
    on<SetupUpdateUserModules>(_onUpdateUserModules);
  }

  void _loading(Emitter<SetupState> emit) {
    emit(state.copyWith(status: SetupStatus.loading));
  }

  void _error(Emitter<SetupState> emit, String message) {
    emit(
      state.copyWith(status: SetupStatus.failure, errorMsg: message),
    );
  }

  void _onCourseSelect(SetupCourseSelect event, Emitter<SetupState> emit) {
    if (state.selectedCourse != event.selectedCourse) {
      emit(state.copyWith(selectedCourse: event.selectedCourse));
    }
  }

  void _onLevelChange(SetupLevelChange event, Emitter<SetupState> emit) {
    if (state.userLevel != event.level) {
      emit(state.copyWith(userLevel: event.level));

      add(SetupGetSortedModules());
    }
  }

  void _onModulesSelectedChange(
      SetupSelectedModule event, Emitter<SetupState> emit) {
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
        state.copyWith(status: SetupStatus.failure, errorMsg: l.message),
      ),
      (r) => emit(state.copyWith(status: SetupStatus.success, courses: r)),
    );
  }

  Future<void> _onGetSortedModules(
    SetupGetSortedModules event,
    Emitter<SetupState> emit,
  ) async {
    _loading(emit);
    final res = await _getSortedModules(CourseModulesParams(
      modules: state.selectedCourse!.modules!,
      maxLevel: state.userLevel,
    ));

    res.fold(
      (l) => _error(emit, l.message),
      (r) {
        final selected = r
            .where(
              (element) => element.level == state.userLevel,
            )
            .toList();
        emit(state.copyWith(
            status: SetupStatus.success,
            modules: r,
            selectedModules: selected));
      },
    );
  }

  Future<void> _onUpdateUserModules(
    SetupUpdateUserModules event,
    Emitter<SetupState> emit,
  ) async {
    emit(state.copyWith(status: SetupStatus.finalizing));
    final res = await _updateUser(UpdateUserModulesParams(
      modules: state.selectedModules,
      level: state.userLevel,
      courseId: state.selectedCourse!.id,
    ));

    res.fold((l) => _error(emit, l.message), (r) {
      final user = _authBloc.state.user!;
      final course = state.selectedCourse!;
      _authBloc.add(AuthUserChanged(
        user: user.copyWith(
          course: CourseModel(
              id: course.id,
              duration: course.duration,
              name: course.name,
              modules: course.modules!
                  .map(
                    (m) => ModuleModel(
                      id: m.id,
                      level: m.level,
                      name: m.name,
                    ),
                  )
                  .toList(),
              predecessors: course.predecessors),
          modules: state.selectedModules
              .map(
                (m) => ModuleModel(
                  id: m.id,
                  level: m.level,
                  name: m.name,
                ),
              )
              .toList(),
        ),
      ));
      emit(state.copyWith(status: SetupStatus.done));
    });
  }
}
