import 'package:doculode/core/common/settings/presentation/bloc/base_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSettings<T extends BaseSettingsBloc> extends StatelessWidget {
  const CourseSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, BaseSettingsState>(
      builder: (context, state) {
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     StyledDropDownTextfield(
        //       label: 'Course',
        //       hintText: 'Select course',
        //       initialList: state.courses,
        //       value: state.selectedCourse,
        //       onSelectionChanged: (course) {
        //         if (course != null) {
        //           context.read<T>().add(SelectCourseEvent(course));
        //         }
        //       },
        //     ),
        //     VSpace.lg,
        //     if (state.selectedCourse != null &&
        //         state.selectedCourse!.duration != null) ...[
        //       StyledDropDownTextfield(
        //         label: 'Year',
        //         hintText: 'Select year',
        //         initialList: List.generate(
        //           state.selectedCourse!.duration!,
        //           (index) => index + 1,
        //         ),
        //         value: state.selectedLevel,
        //         onSelectionChanged: (level) {
        //           if (level != null) {
        //             context.read<T>().add(SelectLevelEvent(level));
        //           }
        //         },
        //       ),
        //     ],
        //   ],
        // );
      return SizedBox();
      },
    );
  }
}
