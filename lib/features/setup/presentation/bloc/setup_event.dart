part of 'setup_bloc.dart';

sealed class SetupEvent extends Equatable {
  const SetupEvent();
}

final class SetupGetAllCourses extends SetupEvent {
  @override
  List<Object?> get props => [];
}

final class SetupGetSortedModules extends SetupEvent {
  @override
  List<Object?> get props => [];
}

final class SetupCourseSelect extends SetupEvent {
  final Course selectedCourse;

  const SetupCourseSelect(this.selectedCourse);

  @override
  List<Object?> get props => [selectedCourse];
}

final class SetupSelectedModule extends SetupEvent {
  final Module module;

  const SetupSelectedModule(this.module);

  @override
  List<Object?> get props => [module];
}

final class SetupLevelChange extends SetupEvent {
  final int level;

  const SetupLevelChange(this.level);

  @override
  List<Object?> get props => [level];
}

final class SetupSemesterChange extends SetupEvent {
  final int semester;

  const SetupSemesterChange(this.semester);

  @override
  List<Object?> get props => [semester];
}

final class SetupUpdateUserModules extends SetupEvent {
  @override
  List<Object?> get props => [];
}
