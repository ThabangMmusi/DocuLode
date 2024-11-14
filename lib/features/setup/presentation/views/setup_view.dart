import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:its_shared/constants/responsive.dart';
import 'package:its_shared/core/bloc/auth/auth_bloc.dart';
import 'package:its_shared/routes/app_pages.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../constants/app_text.dart';
import '../../../../widgets/buttons/styled_buttons.dart';
import '../../../../widgets/styled_dropdown_textfield.dart';
import '../bloc/setup_bloc.dart';
import '../widget/setup_side_image.dart';
import 'step_one_view.dart';
import '../../../../core/components/module_selector.dart';

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
          if (state.status == SetupStatus.done) {
            context.go(Routes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Row(
            children: [
              SizedBox(
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : ((MediaQuery.of(context).size.width * .5)),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.all(Responsive.sidePadding(context))
                        .copyWith(bottom: Insets.lg),
                    color: colorScheme.surface,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _HeaderTitles(),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: state.status == SetupStatus.finalizing,
                            child: Opacity(
                              opacity: state.status == SetupStatus.finalizing
                                  ? 0.75
                                  : 1,
                              child: Column(
                                children: [
                                  if (state.status == SetupStatus.loading &&
                                      state.selectedCourse == null)
                                    const StyledLoadSpinner()
                                  else ...[
                                    const StepOneView(),
                                    VSpace.med,
                                    if (state.selectedCourse != null &&
                                        state.userLevel != 0)
                                      if (state.status == SetupStatus.loading)
                                        Padding(
                                            padding: EdgeInsets.all(Insets.med),
                                            child: const StyledLoadSpinner())
                                      else
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ModuleSelector(
                                                  selectedModules:
                                                      state.selectedModules,
                                                  modules: state.modules,
                                                  onModulePress: (module) =>
                                                      context
                                                          .read<SetupBloc>()
                                                          .add(
                                                              SetupSelectedModule(
                                                                  module)),

                                                  label: "Semester",
                                                  // value: 0,
                                                  listItems: List.generate(
                                                    2,
                                                    (int index) => AppListItem(
                                                        "Semester ${index + 1}",
                                                        value: index + 1),
                                                  ),
                                                  onChange: (p0) {
                                                    context
                                                        .read<SetupBloc>()
                                                        .add(
                                                            SetupSemesterChange(
                                                                p0!));
                                                  },
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                height: 1,
                                              ),
                                              VSpace.lg,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (state.status !=
                                                      SetupStatus.finalizing)
                                                    SecondaryBtn(
                                                      onPressed: () => context
                                                          .read<AuthBloc>()
                                                          .add(
                                                              AuthLogoutRequested()),
                                                      label: "Logout",
                                                    ),
                                                  if (state.status ==
                                                      SetupStatus
                                                          .finalizing) ...[
                                                    HSpace.lg,
                                                    const StyledLoadSpinner()
                                                  ] else
                                                    PrimaryBtn(
                                                      key: const Key(
                                                          'setup_submit_button'),
                                                      onPressed: () => context
                                                          .read<SetupBloc>()
                                                          .add(
                                                              SetupUpdateUserModules()),
                                                      label:
                                                          "Start the Journey",
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (!Responsive.isMobile(context)) const SetupSideImage(),
            ],
          ));
        },
      ),
    );
  }

  double roundToNearestMultipleOfThree(double value) {
    return (3 * (value / 3).round()).toDouble();
  }
}

class _HeaderTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              tAppName,
              style: TextStyles.h2
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
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
              color: Theme.of(context).colorScheme.onInverseSurface),
        ),
        VSpace.med,
      ],
    );
  }
}
