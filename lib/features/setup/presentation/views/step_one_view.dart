import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/styled_dropdown.dart';
import 'package:its_shared/widgets/styled_dropdown_textfield.dart';

import '../../../../_utils/string_utils.dart';

class StepOneView extends StatelessWidget {
  const StepOneView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SetupBloc>().state;
    return Column(
      children: [
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
                  context.read<SetupBloc>().add(SetupCourseSelect(p0));
                },
              ),
            ),
            if (state.selectedCourse != null) ...[
              HSpace(Insets.med),
              SizedBox(
                  width: 150,
                  child: StyledDropDown(
                    label: "Level/Year",
                    // value: 0,
                    listItems: List.generate(
                      state.selectedCourse!.duration!,
                      (int index) => AppListItem(
                          "${index + 1}${StringUtils.getOrdinal(index + 1)} Year",
                          value: index + 1),
                    ),
                    onChange: (p0) {
                      context.read<SetupBloc>().add(SetupLevelChange(p0!));
                    },
                  )),
            ]
          ],
        ),
        // if (state.selectedCourse != null && state.userLevel != null)
        //   if (state.status == SetupStatus.loading)
        //     Padding(
        //         padding: EdgeInsets.all(Insets.lg),
        //         child: const StyledLoadSpinner())
        //   else ...[
        //     VSpace.med,
        //     LabeledTextInput(
        //       // value: state.selectedCourse,
        //       label: "Module",
        //       hintText: "search Modules",
        //       initialList: state.modules
        //           .map((module) => AppListItem(module.name, value: module))
        //           .toList(),
        //       onSelection: (p0) {
        //         // context.read<SetupBloc>().add(SetupCourseSelected(p0));
        //       },
        //     ),
        //   ]
      ],
    );
  }
}
