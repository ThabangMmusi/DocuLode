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

final class SetupModulesSelectedChange extends SetupEvent {
  final Module module;

  const SetupModulesSelectedChange(this.module);

  @override
  List<Object?> get props => [module];
}

final class SetupStepChanged extends SetupEvent {
  final int step;

  const SetupStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

final class SetupLevelChange extends SetupEvent {
  final int level;

  const SetupLevelChange(this.level);

  @override
  List<Object?> get props => [level];
}
