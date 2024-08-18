// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setup_bloc.dart';

enum SetupStatus { initial, loading, success, failure }

extension EditFileStatusX on SetupStatus {
  bool get isLoadingOrSuccess => [
        SetupStatus.loading,
        SetupStatus.success,
      ].contains(this);
}

class SetupState extends Equatable {
  final int step;
  final int? userLevel;
  final SetupStatus status;
  final List<Course> courses;
  final List<Module> modules;
  final Course? selectedCourse;
  final List<Module> selectedModules;
  final String? errorMessage;

  const SetupState({
    this.status = SetupStatus.initial,
    this.step = 1,
    this.userLevel,
    this.courses = const [],
    this.modules = const [],
    this.selectedCourse,
    this.selectedModules = const [],
    this.errorMessage,
  });

  SetupState copyWith({
    SetupStatus? status,
    int? step,
    int? userLevel,
    List<Course>? courses,
    List<Module>? modules,
    Course? selectedCourse,
    List<Module>? selectedModules,
    String? errorMessage,
  }) {
    return SetupState(
      status: status ?? this.status,
      step: step ?? this.step,
      userLevel: userLevel ?? this.userLevel,
      courses: courses ?? this.courses,
      modules: modules ?? this.modules,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      selectedModules: selectedModules ?? this.selectedModules,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        courses,
        modules,
        selectedCourse,
        selectedModules,
        step,
        userLevel,
        errorMessage
      ];
}
