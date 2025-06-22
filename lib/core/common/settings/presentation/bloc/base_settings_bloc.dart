import 'package:doculode/core/index.dart';

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/sign_in/domain/usecases/validate_email_use_case.dart';
import '../../../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'base_settings_event.dart';
part 'base_settings_state.dart';

class BaseSettingsBloc<T extends BaseSettingsState>
    extends Bloc<BaseSettingsEvent, T> {
  final GetAllCoursesUsecase _getAllCourses;
  final GetCourseModulesUsecase _getSortedModules;
  final UpdateUserEdu _updateUserEdu;
  final ValidateEmailUseCase _validateEmail;
  final ValidateNameUseCase _validateName;
  final UserSignOut _signOut;
  final UpdateProfile _updateProfile;

  GetAllCoursesUsecase get getAllCourses => _getAllCourses;
  GetCourseModulesUsecase get getSortedModules => _getSortedModules;

  BaseSettingsBloc({
    required GetAllCoursesUsecase getAllCourses,
    required GetCourseModulesUsecase getSortedModules,
    required UpdateProfile updateProfile,
    required UpdateUserEdu updateUserEdu,
    required ValidateEmailUseCase validateEmail,
    required ValidateNameUseCase validateName,
    required UserSignOut signOut,
    required T initialState,
  })  : _getAllCourses = getAllCourses,
        _getSortedModules = getSortedModules,
        _updateUserEdu = updateUserEdu,
        _updateProfile = updateProfile,
        _validateEmail = validateEmail,
        _validateName = validateName,
        _signOut = signOut,
        super(initialState) {
    on<SelectCourseEvent>(_onCourseSelect);
    on<SelectModuleEvent>(_onModuleSelect);
    on<GetAllCoursesEvent>(onGetAllCourses);
    on<GetSortedModulesEvent>(_onGetSortedModules);
    on<SelectLevelEvent>(_onLevelChange);
    on<UpdateUserEduEvent>(_onUpdateUserEdu);
    on<LoadingEvent>(_loading);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<SignOutRequested>(_onSignOutRequested);
    on<ProfileUpdateRequested>(_onProfileUpdate);
  }

  Future<void> _onProfileUpdate(
    ProfileUpdateRequested event,
    Emitter<T> emit,
  ) async {
    add(LoadingEvent());
    final res = await _updateProfile(ProfileParams(
      names: event.names,
      surname: event.surname,
    ));

    res.fold(
      (l) => error(emit, l.message),
      (r) {
        emit(state.copyWith(
          status: SettingsStatus.success,
          firstNames: event.names,
          lastName: event.surname,
          email: event.email,
        ) as T);
      },
    );
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<T> emit) async {
    final result = await _validateName(event.name);
    result.fold(
      (l) => emit(state.copyWith(
        lastName: event.name,
        lastNameError: l.message,
        isNamesValid: false,
      ) as T),
      (r) => emit(state.copyWith(
        lastName: event.name,
        lastNameError: "",
        isNamesValid:
            state.firstNamesError.isEmpty && state.firstNames.isNotEmpty,
      ) as T),
    );
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<T> emit) async {
    final result = await _validateName(event.name);
    result.fold(
      (l) => emit(state.copyWith(
        firstNames: event.name,
        firstNamesError: l.message,
        isNamesValid: false,
      ) as T),
      (r) => emit(state.copyWith(
        firstNames: event.name,
        firstNamesError: "",
        isNamesValid: state.lastNameError.isEmpty && state.lastName.isNotEmpty,
      ) as T),
    );
  }

  void _loading(LoadingEvent event, Emitter<T> emit) =>
      emit(state.copyWith(status: SettingsStatus.loadingCourses) as T);

  void error(Emitter<T> emit, String message) => emit(
      state.copyWith(status: SettingsStatus.error, errorMsg: message) as T);

  void _onCourseSelect(SelectCourseEvent event, Emitter<T> emit) {
    if (state.selectedCourse == event.selectedCourse) return;
    emit(state.copyWith(
      selectedCourse: event.selectedCourse,
      selectedLevel: 0, // Reset year/level
      selectedModules: const [], // Reset modules/semester selection
      modules: const [], // Optionally clear modules list as well
    ) as T);
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
        final selected = r.where((e) =>  2== state.selectedLevel).toList();
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

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<T> emit) async {
    emit(state.copyWith(status: SettingsStatus.signingOut) as T);
    final res = await _signOut(NoParams());
    res.fold(
      (l) => error(emit, l.message),
      (r) => emit(state.copyWith(status: SettingsStatus.loggedOff) as T),
    );
  }
}
