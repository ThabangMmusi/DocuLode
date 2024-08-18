import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/constants/responsive.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/decorated_container.dart';
import 'package:its_shared/widgets/labeled_text_input.dart';
import 'package:its_shared/widgets/styled_dropdown.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../constants/app_text.dart';
import '../../../../widgets/styled_dropdown_textfield.dart';
import '../../domain/entities/module.dart';
import '../bloc/setup_bloc.dart';
import '../widget/module_widget.dart';

class StepperStep {
  final bool isActive;
  final bool isCompleted;
  final String stepNumber;

  StepperStep(this.stepNumber,
      {this.isActive = false, this.isCompleted = false});
}

class SetupView extends StatefulWidget {
  const SetupView({super.key});

  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  @override
  void initState() {
    super.initState();
    context.read<SetupBloc>().add(SetupGetAllCourses());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SafeArea(
      child: BlocConsumer<SetupBloc, SetupState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              // buildImage(context),
              // BackdropFilter(
              //   filter: ImageFilter.blur(
              //       sigmaX: 50, sigmaY: 50, tileMode: TileMode.repeated),
              //   child: ClipRect(
              //     child: Container(
              //       color: colorScheme.tertiaryContainer.withOpacity(.1),
              //     ),
              //   ),
              // ),
              buildImage(context),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: roundToNearestMultipleOfThree(
                      (MediaQuery.of(context).size.width * .5)),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: EdgeInsets.all(Responsive.sidePadding(context))
                          .copyWith(bottom: Insets.lg),
                      color: colorScheme.surface,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                tAppName,
                                style: TextStyles.h2.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                          // _StepsProgress(),
                          VSpace(Insets.xl),
                          Text(
                            "Welcome!",
                            textAlign: TextAlign.center,
                            style: TextStyles.h1,
                          ),
                          VSpace.med,
                          Text(
                            "Lets finalize few things...",
                            textAlign: TextAlign.center,
                            style: TextStyles.h3,
                          ),
                          Text(
                            "You can always change them later.",
                            style: TextStyles.body2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface),
                          ),
                          VSpace.med,
                          if (state.status == SetupStatus.loading &&
                              state.selectedCourse == null)
                            const StyledLoadSpinner()
                          else ...[
                            // if (state.step == 1)
                            _StepOneView(),
                            // if (state.step == 2)
                            VSpace.med,
                            if (state.selectedCourse != null &&
                                state.userLevel != null)
                              if (state.status == SetupStatus.loading)
                                Padding(
                                    padding: EdgeInsets.all(Insets.lg),
                                    child: const StyledLoadSpinner())
                              else
                                _StepTwoView(),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }

  double roundToNearestMultipleOfThree(double value) {
    return (3 * (value / 3).round()).toDouble();
  }

  Align buildImage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: Padding(
          padding: EdgeInsets.all(Insets.lg),
          child: DecoratedContainer(
            color: colorScheme.primary,
            borderRadius: Corners.lg,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(Insets.xl),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Insets.xl),
                      child: Text(
                        "Take Control, Be in Control",
                        style: TextStyles.h1.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    VSpace.xl,
                    Transform.rotate(
                      angle: 12.5,
                      child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 400, maxWidth: 400),
                        // width: 400,
                        clipBehavior: Clip.antiAlias,
                        // height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: Corners.lgBorder,
                          // border:
                        ),
                        child: Image.asset("assets/images/landing.jpg",
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _StepsProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SetupBloc>().state;
    return SizedBox(
      height: 35,
      width: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildStep(true, '1', context),
          buildLine(state.step > 1, context),
          buildStep(state.step > 1, '2', context),
          buildLine(state.step > 2, context),
          buildStep(state.step > 2, '3', context),
        ],
      ),
    );
  }

  Widget buildStep(bool isActive, String stepNumber, BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Color primary = colors.primary;
    Color onSurface = colors.onSurface;
    Color onPrimary = colors.onPrimary;
    Color border = colors.onInverseSurface;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Insets.sm),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? primary : Colors.transparent,
              border: Border.all(
                color: isActive ? Colors.transparent : border,
              )),
          child: Text(stepNumber,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isActive ? onPrimary : onSurface,
                  )),
        ),
      ],
    );
  }

  Widget buildLine(bool isActive, BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Color primary = colors.primary;
    Color tertiary = colors.tertiary;
    return Expanded(
      child: Container(
        height: 1,
        color: isActive ? primary : tertiary,
      ),
    );
  }
}

const List<String> _modules = <String>[
  'Applications Development Foundations',
  'ICT Fundamentals',
  'Web Development I',
  'Core Curriculum',
  'Programming I',
  'Communication Networks Foundations I',
  'Information Systems I',
  'Business Practice',
  'Introduction to Computational Mathematics'
];

class _StepTwoView extends StatefulWidget {
  @override
  State<_StepTwoView> createState() => _StepTwoViewState();
}

class _StepTwoViewState extends State<_StepTwoView> {
  List<Module> _suggestions = [];
  TextEditingController controller = TextEditingController();
  late List<Module> filteredLists;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SetupBloc>().state;
    filteredLists = state.modules;
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Responsive.sidePadding(context)),
        child: Column(
          children: [
            LabeledTextInput(
              label: "Modules",
              hintText: "Search for module",
              controller: controller,
              onChanged: _onSearchChanged,
            ),
            VSpace(Insets.med + 3),
            _buildChips(controller.text.isEmpty ? state.modules : _suggestions),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            VSpace.lg,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if (state.step > 1)
                SecondaryBtn(
                  onPressed: () {
                    context
                        .read<SetupBloc>()
                        .add(SetupStepChanged(state.step - 1));
                  },
                  label: "Logout",
                ),
                // HSpace.lg,

                PrimaryBtn(
                  key: const Key('setup_submit_button'),
                  onPressed: () {
                    context
                        .read<SetupBloc>()
                        .add(SetupStepChanged(state.step + 1));
                  },
                  label: "Start the Journey",
                  // child: Container(
                  //     alignment: Alignment.center,
                  //     child: Text("Start the Journey", style: TextStyles.callout1)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChips(List<Module> modules) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => ModuleWidget(modules[index]),
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                height: 1,
              ),
          itemCount: modules.length),
    );
  }

  void _onSearchChanged(String value) {
    List<Module> tempList = [];
    for (Module item in filteredLists) {
      if (item.name.toLowerCase().contains(value.toLowerCase())) {
        tempList.add(item);
      }
    }
    // final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = tempList;
      // .where((String topping) => !_toppings.contains(topping))
      // .toList();
    });
  }

  // FutureOr<List<Module>> _suggestionCallback(String text) {
  //   if (text.isNotEmpty) {

  //     return _modules.where((Module topping) {
  //       return topping.name.toLowerCase().contains(text.toLowerCase());
  //     }).toList();
  //   }
  //   return const [];
  // }
}

class _StepOneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SetupBloc>().state;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.sidePadding(context)),
      child: Column(
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
                      .map((course) => AppListItem(course.name, value: course))
                      .toList(),
                  onSelection: (p0) {
                    context.read<SetupBloc>().add(SetupCourseSelect(p0));
                  },
                ),
              ),
              if (state.selectedCourse != null) ...[
                HSpace(Insets.med),
                SizedBox(
                    width: 100,
                    child: StyledDropDown(
                      label: "Level/Year",
                      // value: 0,
                      listItems: List.generate(
                        state.selectedCourse!.duration,
                        (int index) =>
                            AppListItem("Year ${index + 1}", value: index + 1),
                      ),
                      onChange: (p0) {
                        context.read<SetupBloc>().add(SetupLevelChange(p0!));
                        context.read<SetupBloc>().add(SetupGetSortedModules());
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
      ),
    );
  }
}
