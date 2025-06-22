import 'package:equatable/equatable.dart';

class AcademicSubmissionEntity extends Equatable {
  final String? selectedCourseId; // Internal DB ID of the CourseModel
  final int? selectedYear;
  final int? selectedSemester;
  final List<String> selectedModuleIds; // List of internal DB IDs of ModuleModels

  const AcademicSubmissionEntity({
    this.selectedCourseId,
    this.selectedYear,
    this.selectedSemester,
    required this.selectedModuleIds,
  });

  @override
  List<Object?> get props => [
        selectedCourseId, selectedYear, selectedSemester, selectedModuleIds,
      ];
}