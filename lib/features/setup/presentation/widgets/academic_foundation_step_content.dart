import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/domain/entities/index.dart';
import 'package:doculode/core/utils/string_utils.dart';
import 'package:doculode/core/widgets/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/index.dart';
import '../../../../core/widgets/index.dart';
import '../bloc/setup_bloc.dart';

class AcademicFoundationStepContent extends StatelessWidget {
  final SetupState state;
  const AcademicFoundationStepContent({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    final List<AppListItem<CourseModel>> programs = state.availableCourses
        .map((c) =>
            AppListItem<CourseModel>(c.name ?? 'Unknown Course', value: c))
        .toList();
    final CourseModel? selectedCourse = state.selectedCourse;
    final List<AppListItem<int>> years = selectedCourse != null
        ? List.generate(
            selectedCourse.duration!,
            (i) => AppListItem("${i + 1}${StringUtils.getOrdinal(i + 1)} Year",
                value: i + 1))
        : [];
    final int? selectedYear = state.selectedYear;
    final List<AppListItem<int>> semesters = state.availableSemesters
        .map((s) => AppListItem("Semester $s", value: s))
        .toList();
    final int? selectedSemester = state.selectedSemester;
    final bool isLoadingCoursesUserName =
        (state.activeOperation == SetupOperation.loadingCourses || 
        state.activeOperation == SetupOperation.loadingUserName) &&
            state.operationStatus == OperationStatus.inProgress;
    final bool canProceed =
        state.isAcademicFoundationValid && !isLoadingCoursesUserName;

    if (isLoadingCoursesUserName) {
      return Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StyledLoadSpinner.small(),
          VSpace.med,
          Text("Initializing....", style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ));
    }
    return Column(
        key: const ValueKey('academic_foundation_content_widget'),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        StyledDropDownTextfield<CourseModel>(
            label: tProfileAcademicProgramLabel,
            hintText: "Select program",
            initialList: programs,
            value: selectedCourse,
            onSelectionChanged: (c) =>
                context.read<SetupBloc>().add(CourseChanged(c)),
            errorText: state.selectedCourseError),
        VSpace.lg,
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Opacity(
                  opacity: selectedCourse != null ? 1.0 : 0.4,
                  child: IgnorePointer(
                      ignoring: selectedCourse == null,
                      child: StyledDropDownTextfield<int>(
                          label: tProfileYearOfStudyLabel,
                          hintText: "Select year",
                          initialList: years,
                          value: selectedYear,
                          onSelectionChanged: (y) => context
                              .read<SetupBloc>()
                              .add(YearChanged(y)),
                          errorText: state.selectedYearError)))),
          HSpace.med,
          Expanded(
              child: Opacity(
                  opacity: selectedYear != null ? 1.0 : 0.4,
                  child: IgnorePointer(
                      ignoring: selectedYear == null,
                      child: StyledDropDownTextfield<int>(
                          label: tProfileSemesterLabel,
                          hintText: "Select semester",
                          initialList: semesters,
                          value: selectedSemester,
                          onSelectionChanged: (s) => context
                              .read<SetupBloc>()
                              .add(SemesterChanged(s)),
                          errorText: state.selectedSemesterError)))),
        ]),
        VSpace.xxl,
        PrimaryBtn(
            label: tNext.toUpperCase(),
            onPressed: canProceed
                ? () => context.read<SetupBloc>().add(
                    const ChangeTheStep(SetupStep.moduleSelection))
                : null),
       
        // VSpace.med,
        // SecondaryBtn(
        //     label: tBackButton,
        //     icon: Ionicons.arrow_back_outline,
        //     onPressed: isLoadingCourses
        //         ? null
        //         : () => context.read<SetupBloc>().add(
//             const ChangeTheStep(SetupStep.personalDetails)),
        //             ),
      ]);
  }
}
