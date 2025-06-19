// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'base_settings_bloc.dart';

enum SettingsStatus {
  initial,
  loadingCourses,
  loadingModules,
  success,
  error,
  finalizing,
  deleting,
  deleted,
  done,
  signingOut,
  loggedOff
}

extension EditFileStatusX on SettingsStatus {
  bool get isLoadingOrSuccess => [
        SettingsStatus.loadingCourses,
        SettingsStatus.success,
      ].contains(this);
}

abstract class BaseSettingsState extends Equatable {
  final String firstNames;
  final String lastName;
  final String email;
  final String firstNamesError;
  final String lastNameError;
  final String emailError;
  final String imageUrl;
  final int selectedLevel;
  final SettingsStatus status;
  final List<Course> courses;
  final List<Module> modules;
  final Course? selectedCourse;
  final List<Module> selectedModules;
  final String? errorMsg;
  final bool isNamesValid, isPersonalDetailValid;

  const BaseSettingsState({
    this.status = SettingsStatus.initial,
    this.firstNames = "",
    this.lastName = "",
    this.email = "",
    this.imageUrl = "",
    this.selectedLevel = 0,
    this.courses = const [],
    this.modules = const [],
    this.selectedCourse,
    this.selectedModules = const [],
    this.errorMsg,
    this.firstNamesError = "",
    this.lastNameError = "",
    this.emailError = "",
    this.isNamesValid = false,
    this.isPersonalDetailValid = false,
  });

  BaseSettingsState copyWith({
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
  });

  @override
  List<Object?> get props => [
        firstNames,
        lastName,
        email,
        imageUrl,
        status,
        courses,
        modules,
        selectedCourse,
        selectedModules,
        selectedLevel,
        errorMsg,
        firstNamesError,
        lastNameError,
        emailError,
        isNamesValid,
        isPersonalDetailValid,
      ];
}
