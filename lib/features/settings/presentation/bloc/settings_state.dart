part of 'settings_bloc.dart';

class SettingsState extends BaseSettingsState {
  // final String theme;
  // final bool showRecentLists;
  // final bool enableSounds;

  const SettingsState({
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
    // required this.theme,
    // required this.showRecentLists,
    // required this.enableSounds,
  });

  @override
  SettingsState copyWith({
    SettingsStatus? status,
    String? firstNames,
    String? lastName,
    String? email,
    String? imageUrl,
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
    return SettingsState(
      status: status ?? this.status,
      firstNames: firstNames ?? this.firstNames,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      // theme: theme ?? this.theme,
      // showRecentLists: showRecentLists ?? this.showRecentLists,
      // enableSounds: enableSounds ?? this.enableSounds,
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

// Optionally, add a status for sign-out if you want to show a loading or confirmation state
// Example:
// SettingsStatus.signingOut
