// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setup_bloc.dart';

enum SetupStatus { initial, loading, success, failure, finalizing, done }

extension EditFileStatusX on SetupStatus {
  bool get isLoadingOrSuccess => [
        SetupStatus.loading,
        SetupStatus.success,
      ].contains(this);
}

class SetupState extends Equatable {
  final int userLevel;
  final SetupStatus status;
  final List<Course> courses;
  final List<Module> modules;
  final Course? selectedCourse;
  final List<Module> selectedModules;
  final String? errorMsg;

  const SetupState({
    this.status = SetupStatus.initial,
    this.userLevel = 0,
    this.courses = const [],
    this.modules = const [],
    this.selectedCourse,
    this.selectedModules = const [],
    this.errorMsg,
  });

  SetupState copyWith({
    SetupStatus? status,
    int? step,
    int? userLevel,
    List<Course>? courses,
    List<Module>? modules,
    Course? selectedCourse,
    List<Module>? selectedModules,
    String? errorMsg,
  }) {
    return SetupState(
      status: status ?? this.status,
      userLevel: userLevel ?? this.userLevel,
      courses: courses ?? this.courses,
      modules: modules ?? this.modules,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      selectedModules: selectedModules ?? this.selectedModules,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [
        status,
        courses,
        modules,
        selectedCourse,
        selectedModules,
        userLevel,
        errorMsg
      ];
}
