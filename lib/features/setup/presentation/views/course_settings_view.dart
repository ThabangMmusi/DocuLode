import 'package:doculode/config/index.dart';
import 'package:doculode/core/common/auth/presentation/bloc/auth_bloc.dart';
import 'package:doculode/core/common/settings/settings.dart';
import 'package:doculode/core/constants/responsive.dart';
import 'package:doculode/core/domain/entities/app_list_item.dart';
import 'package:doculode/routes/index.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doculode/core/constants/app_text.dart';
import 'package:doculode/core/common/settings/presentation/views/step_one_view.dart';

import 'package:doculode/widgets/styled_dropdown_textfield.dart';
import 'package:doculode/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:doculode/features/setup/presentation/widget/setup_side_image.dart';
import 'package:doculode/core/components/module_selector.dart';

class SetupView extends StatefulWidget {
  const SetupView({super.key});

  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  @override
  void initState() {
    super.initState();
    context.read<SetupBloc>().add(GetAllCoursesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isMobile = Responsive.isMobile(context);

    return SafeArea(
      child: BlocConsumer<SetupBloc, BaseSettingsState>(
        listener: (_, state) {
          if (state.status == SettingsStatus.done) {
            context.go(Routes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: isMobile ? size.width : (size.width * 0.5),
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
                            child: _buildMainContent(state, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isMobile) const SetupSideImage(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(BaseSettingsState state, BuildContext context) {
    final isLoading = state.status == SettingsStatus.loadingCourses;
    final isFinalizing = state.status == SettingsStatus.finalizing;

    return IgnorePointer(
      ignoring: isFinalizing,
      child: Opacity(
        opacity: isFinalizing ? 0.75 : 1,
        child: Column(
          children: [
            if (isLoading && state.selectedCourse == null)
              const StyledLoadSpinner()
            else ...[
              const CourseSettings<SetupBloc>(),
              VSpace.med,
              if (state.selectedCourse != null && state.selectedLevel != 0)
                _buildModuleSection(state, context),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildModuleSection(BaseSettingsState state, BuildContext context) {
    if (state.status == SettingsStatus.loadingCourses) {
      return Padding(
        padding: EdgeInsets.all(Insets.med),
        child: const StyledLoadSpinner(),
      );
    }

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ModuleSelector(
              selectedModules: state.selectedModules,
              modules: state.modules,
              onModulePress: (module) =>
                  context.read<SetupBloc>().add(SelectModuleEvent(module)),
              label: "Semester",
              listItems: List.generate(
                2,
                (index) =>
                    AppListItem("Semester ${index + 1}", value: index + 1),
              ),
              onChange: (value) =>
                  context.read<SetupBloc>().add(SelectSemesterEvent(value!)),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          VSpace.lg,
          _buildActionButtons(state, context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BaseSettingsState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (state.status != SettingsStatus.finalizing)
          SecondaryBtn(
            onPressed: () =>
                context.read<AuthBloc>().add(AuthLogoutRequested()),
            label: "Logout",
          ),
        if (state.status == SettingsStatus.finalizing) ...[
          HSpace.lg,
          const StyledLoadSpinner()
        ] else
          PrimaryBtn(
            key: const Key('setup_submit_button'),
            onPressed: () =>
                context.read<SetupBloc>().add(UpdateUserEduEvent()),
            label: "Start the Journey",
          ),
      ],
    );
  }
}

class _HeaderTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              tAppName,
              style: TextStyles.headlineMedium
                  .copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        VSpace(Insets.xl),
        Text("Welcome!",
            textAlign: TextAlign.center, style: TextStyles.displayLarge),
        VSpace.med,
        Text(
          "Lets finalize few things...",
          textAlign: TextAlign.center,
          style: TextStyles.headlineSmall,
        ),
        Text(
          "You can always change them later.",
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.onInverseSurface,
          ),
        ),
        VSpace.med,
      ],
    );
  }
}
