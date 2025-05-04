part of 'settings_bloc.dart';
class SettingsState extends BaseSettingsState {
  final String names;
  final String lastName;
  final String email;
  final String imageUrl;
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
    this.names = '',
    this.lastName = '',
    this.email = '',
    this.imageUrl = '',
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
  }) {
    return SettingsState(
      status: status ?? this.status,
      names: firstNames ?? names,
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
    );
  }
}
