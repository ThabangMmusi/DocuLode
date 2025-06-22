part of 'setup_bloc.dart';

abstract class SetupEvent extends Equatable {
  const SetupEvent();

  @override
  List<Object?> get props => [];
}

class FirstNameChanged extends SetupEvent {
  final String firstName;
  const FirstNameChanged(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class LastNameChanged extends SetupEvent {
  final String lastName;
  const LastNameChanged(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class ChangeTheStep extends SetupEvent {
  final SetupStep targetFlow;
  const ChangeTheStep(this.targetFlow);

  @override
  List<Object?> get props => [targetFlow];
}

class GetAllCoursesRequest extends SetupEvent {
  // Renamed from LoadInitialData for clarity from UI perspective
  const GetAllCoursesRequest();

}

class ImageChanged extends SetupEvent {
  final File? imageFile;
  const ImageChanged(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class CourseChanged extends SetupEvent {
  final CourseModel? course;
  const CourseChanged(this.course);

  @override
  List<Object?> get props => [course];
}

class YearChanged extends SetupEvent {
  final int? selectedYear;
  const YearChanged(this.selectedYear);

  @override
  List<Object?> get props => [selectedYear];
}

class SemesterChanged extends SetupEvent {
  final int? semester;
  const SemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class LoadModulesRequested extends SetupEvent {
  final int forYear;
  final int? forSemester;
  const LoadModulesRequested({
    required this.forYear,
    this.forSemester,
  });
  @override
  List<Object?> get props => [forYear, forSemester];
}

class ModuleToggled extends SetupEvent {
  final ModuleModel module;
  final int forYear;
  const ModuleToggled(this.module, this.forYear);

  @override
  List<Object?> get props => [module, forYear];
}

class SubmitRegistration extends SetupEvent {
  const SubmitRegistration();

  @override
  List<Object?> get props => [];
}

class SelectedYearsChanged extends SetupEvent {
  final Set<int> years;
  const SelectedYearsChanged(this.years);

  @override
  List<Object?> get props => [years];
}
