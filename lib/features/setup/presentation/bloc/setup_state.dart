part of 'setup_bloc.dart';

enum SetupType { personal, academics }

class SetupState extends BaseSettingsState {
  final SetupType formType;
  const SetupState({
    this.formType = SetupType.personal,
    super.status,
    super.courses,
    super.modules,
    super.selectedLevel,
    super.selectedCourse,
    super.selectedModules,
    super.errorMsg,
    super.firstNames,
    super.lastName,
    super.email,
    super.imageUrl,
    super.firstNamesError,
    super.lastNameError,
    super.emailError,
    super.isNamesValid,
    super.isPersonalDetailValid,
  });

  @override
  SetupState copyWith({
    SetupType? formType,
    String? firstNames,
    String? lastName,
    String? email,
    String? imageUrl,
    SettingsStatus? status,
    int? selectedLevel,
    List<Course>? courses,
    List<Module>? modules,
    Course? selectedCourse,
    List<Module>? selectedModules,
    String? errorMsg,
    String? firstNamesError,
    String? lastNameError,
    String? emailError,
    bool? isNamesValid,
    bool? isPersonalDetailValid,
  }) {
    return SetupState(
      formType: formType ?? this.formType,
      firstNames: firstNames ?? this.firstNames,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      courses: courses ?? this.courses,
      modules: modules ?? this.modules,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      selectedModules: selectedModules ?? this.selectedModules,
      errorMsg: errorMsg ?? this.errorMsg,
      firstNamesError: firstNamesError ?? this.firstNamesError,
      lastNameError: lastNameError ?? this.lastNameError,
      emailError: emailError ?? this.emailError,
      isNamesValid: isNamesValid ?? this.isNamesValid,
      isPersonalDetailValid:
          isPersonalDetailValid ?? this.isPersonalDetailValid,
    );
  }
}
