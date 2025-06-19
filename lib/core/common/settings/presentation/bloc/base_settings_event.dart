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

final class FirstNameChanged extends BaseSettingsEvent {
  final String name;
  const FirstNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

final class LastNameChanged extends BaseSettingsEvent {
  final String name;
  const LastNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

final class SignOutRequested extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}

final class ProfileUpdateRequested extends BaseSettingsEvent {
  final String names;
  final String surname;
  final String email;

  const ProfileUpdateRequested({
    required this.names,
    required this.surname,
    required this.email,
  });

  @override
  List<Object?> get props => [names, surname, email];
}
