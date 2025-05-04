import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/_utils/string_utils.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/styled_dropdown.dart';
import 'package:its_shared/widgets/styled_dropdown_textfield.dart';

import '../../../../../widgets/styled_load_spinner.dart';
import '../../../../components/module_selector.dart';
import '../bloc/base_settings_bloc.dart';

class CourseSettings<T extends BaseSettingsBloc> extends StatelessWidget {
  const CourseSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<T>().state;
    final isLoadingCourses = state.status == SettingsStatus.loadingCourses;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Show loading spinner if loading courses or modules
        if (isLoadingCourses)
          const SizedBox(height: 25, child: StyledLoadSpinner())
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: StyledDropDownTextfield(
                  value: state.selectedCourse,
                  label: "Course",
                  hintText: "Diploma in ICT",
                  initialList: state.courses
                      .map((course) => AppListItem(course.name!, value: course))
                      .toList(),
                  onSelection: (p0) {
                    context.read<T>().add(SelectCourseEvent(p0));
                  },
                ),
              ),
              if (state.selectedCourse != null) ...[
                HSpace(Insets.med),
                SizedBox(
              width: 180,
                  child: StyledDropDown(
                    label: "Level/Year",
                    value: state.selectedLevel,
                    listItems: List.generate(
                      state.selectedCourse!.duration!,
                      (int index) => AppListItem(
                        "${index + 1}${StringUtils.getOrdinal(index + 1)} Year",
                        value: index + 1,
                      ),
                    ),
                    onChange: (p0) {
                      context.read<T>().add(SelectLevelEvent(p0!));
                    },
                  ),
                ),
              ]
            ],
          ),
        VSpace.med,
        if (state.selectedCourse != null &&
            state.selectedLevel != 0 &&
            !isLoadingCourses)
          _buildModuleSection(state, context),
      ],
    );
  }

  Widget _buildModuleSection(BaseSettingsState state, BuildContext context) {
    final isLoadingModules = state.status == SettingsStatus.loadingModules;
    return ModuleSelector(
      modules: state.modules,
      isLoadingModules: isLoadingModules,
      selectedModules: state.selectedModules,
      onModulePress: (module) =>
          context.read<T>().add(SelectModuleEvent(module)),
      label: "Semester",
      listItems: List.generate(
        2,
        (index) => AppListItem("Semester ${index + 1}", value: index + 1),
      ),
      onChange: (value) =>
          context.read<T>().add(SelectSemesterEvent(value!)),
    );
  }
}
