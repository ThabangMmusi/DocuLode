// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'base_settings_bloc.dart';

enum SettingsStatus { initial, loadingCourses,loadingModules, success, error, finalizing, deleting,deleted, done }

extension EditFileStatusX on SettingsStatus {
  bool get isLoadingOrSuccess => [
        SettingsStatus.loadingCourses,
        SettingsStatus.success,
      ].contains(this);
}

abstract class BaseSettingsState extends Equatable {
  final int selectedLevel;
  final SettingsStatus status;
  final List<Course> courses;
  final List<Module> modules;
  final Course? selectedCourse;
  final List<Module> selectedModules;
  final String? errorMsg;

  const BaseSettingsState({
    this.status = SettingsStatus.initial,
    this.selectedLevel = 0,
    this.courses = const [],
    this.modules = const [],
    this.selectedCourse,
    this.selectedModules = const [],
    this.errorMsg,
  });

  BaseSettingsState copyWith({
    SettingsStatus? status,
    int? selectedLevel,
    List<Course>? courses,
    List<Module>? modules,
    Course? selectedCourse,
    List<Module>? selectedModules,
    String? errorMsg,
  });

  @override
  List<Object?> get props => [
        status,
        courses,
        modules,
        selectedCourse,
        selectedModules,
        selectedLevel,
        errorMsg,
      ];
}
