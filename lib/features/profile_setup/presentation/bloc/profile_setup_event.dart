// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_setup_bloc.dart';

abstract class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object?> get props => [];
}

class FirstNameChanged extends ProfileSetupEvent {
  final String firstName;
  const FirstNameChanged(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class GetUserName extends ProfileSetupEvent {
  const GetUserName();
}

class LastNameChanged extends ProfileSetupEvent {
  final String lastName;
  const LastNameChanged(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class ChangeTheStep extends ProfileSetupEvent {
  final ProfileSetupStep targetFlow;
  const ChangeTheStep(this.targetFlow);

  @override
  List<Object?> get props => [targetFlow];
}

class GetAllCoursesRequest extends ProfileSetupEvent {
  // Renamed from LoadInitialProfileData for clarity from UI perspective
  const GetAllCoursesRequest();

}

class ProfileImageChanged extends ProfileSetupEvent {
  final File? imageFile;
  const ProfileImageChanged(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class CourseChanged extends ProfileSetupEvent {
  final CourseModel? course;
  const CourseChanged(this.course);

  @override
  List<Object?> get props => [course];
}

class YearChanged extends ProfileSetupEvent {
  final int? selectedYear;
  const YearChanged(this.selectedYear);

  @override
  List<Object?> get props => [selectedYear];
}

class SemesterChanged extends ProfileSetupEvent {
  final int? semester;
  const SemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class LoadModulesRequested extends ProfileSetupEvent {
  final int forYear;
  final int? forSemester;
  const LoadModulesRequested({
    required this.forYear,
    this.forSemester,
  });
  @override
  List<Object?> get props => [forYear, forSemester];
}

class ModuleToggled extends ProfileSetupEvent {
  final ModuleModel module;
  final int forYear;
  const ModuleToggled(this.module, this.forYear);

  @override
  List<Object?> get props => [module, forYear];
}

class SubmitRegistration extends ProfileSetupEvent {
  const SubmitRegistration();

  @override
  List<Object?> get props => [];
}

class SelectedYearsChanged extends ProfileSetupEvent {
  final Set<int> years;
  const SelectedYearsChanged(this.years);

  @override
  List<Object?> get props => [years];
}
