part of 'setup_bloc.dart';

class SetupState extends BaseSettingsState  {
   const SetupState({
    super.status,
    super.courses,
    super.modules,
    super.selectedLevel,
    super.selectedCourse,
    super.selectedModules,
    super.errorMsg,
  });

  @override
  SetupState copyWith({
    SettingsStatus? status,
    int? selectedLevel,
    List<Course>? courses,
    List<Module>? modules,
    Course? selectedCourse,
    List<Module>? selectedModules,
    String? errorMsg,
  }) {
    return SetupState(
      status: status ?? this.status,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      courses: courses ?? this.courses,
      modules: modules ?? this.modules,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      selectedModules: selectedModules ?? this.selectedModules,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}