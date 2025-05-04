part of 'base_settings_bloc.dart';

abstract class BaseSettingsEvent extends Equatable {
  const BaseSettingsEvent();
}

final class GetAllCoursesEvent extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}

final class GetSortedModulesEvent extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}

final class SelectCourseEvent extends BaseSettingsEvent {
  final Course selectedCourse;

  const SelectCourseEvent(this.selectedCourse);

  @override
  List<Object?> get props => [selectedCourse];
}

final class SelectModuleEvent extends BaseSettingsEvent {
  final Module module;

  const SelectModuleEvent(this.module);

  @override
  List<Object?> get props => [module];
}

final class SelectLevelEvent extends BaseSettingsEvent {
  final int level;

  const SelectLevelEvent(this.level);

  @override
  List<Object?> get props => [level];
}

final class SelectSemesterEvent extends BaseSettingsEvent {
  final int semester;

  const SelectSemesterEvent(this.semester);

  @override
  List<Object?> get props => [semester];
}

final class UpdateUserEduEvent extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}

final class LoadingEvent extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}
