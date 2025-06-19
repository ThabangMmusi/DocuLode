import 'package:doculode/config/index.dart';
import 'package:doculode/core/common/settings/settings.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/core/domain/entities/app_list_item.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setup_bloc.dart';

class SetupAcademicContent extends StatelessWidget {
  const SetupAcademicContent({super.key});

  Widget _buildSuccessView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      key: const ValueKey('signup_success_view'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: colorScheme.primaryContainer.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 3)
              ]),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 56),
        ),
        const SizedBox(height: 30),
        const AuthHeader(
          headerText: 'Sign Up Successful!',
          subHeaderText:
              'Redirecting you shortly, after you verify your email.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        if (state.status == SettingsStatus.done) {
          return Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildSuccessView(context)));
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              final bool isEnteringEmailForm =
                  (child.key == const ValueKey('email_signup_form_wrapper'));
              final Offset beginOffset = isEnteringEmailForm
                  ? const Offset(0, 0.1)
                  : const Offset(0, -0.05);
              return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                      position:
                          Tween<Offset>(begin: beginOffset, end: Offset.zero)
                              .animate(animation),
                      child: child));
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: _buildEmailFormWrapper(context, state),
            ));
      },
    );
  }

  Widget _buildEmailFormWrapper(BuildContext context, SetupState state) {
    return Column(
      key: const ValueKey('email_signup_form_wrapper'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AuthHeader(
          headerText: tSignUpTitle,
          subHeaderText: tSignUpSubTitle,
        ),
        _buildMainContent(state, context),
      ],
    );
  }

  Widget _buildMainContent(SetupState state, BuildContext context) {
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

  Widget _buildModuleSection(SetupState state, BuildContext context) {
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

  Widget _buildActionButtons(SetupState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (state.status != SettingsStatus.finalizing)
          SecondaryBtn(
            onPressed: null,
            // () =>
            //     context.read<SetupState>().add(AuthLogoutRequested()),
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
