import 'package:doculode/config/index.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../bloc/profile_setup_bloc.dart';
import 'widgets.dart';

class ProfileOverlayContent extends StatelessWidget {
  const ProfileOverlayContent({super.key});

  Future<void> _pickProfileImage(BuildContext context) async {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text("Profile image picker: TODO")),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
      buildWhen: (prev, current) =>
          prev.firstName != current.firstName ||
          prev.currentFlow != current.currentFlow,
      builder: (context, state) {
        String titleText;
        String subtitleText = tProfileOverlaySubtitle;
        int currentStepIndex = 0;

        final String displayName = state.firstName.split(' ').first;

        List<StepData> stepperData = [
          StepData(
              title: "Personal Info",
              status: StepStatus.pending,
              inProgressIcon: Ionicons.person_circle_outline,
              completedIcon: Ionicons.person_circle),
          StepData(
              title: "Academics",
              status: StepStatus.pending,
              inProgressIcon: Ionicons.school_outline,
              pendingIcon: Ionicons.school_outline),
          StepData(
              title: "Modules",
              status: StepStatus.pending,
              inProgressIcon: Ionicons.library_outline,
              pendingIcon: Ionicons.library_outline),
        ];

        switch (state.currentFlow) {
          case ProfileSetupStep.personalDetails:
            titleText = displayName.isNotEmpty
                ? "$tWelcomeToProfileSetup, $displayName!"
                : tWelcomeToProfileSetupExclaim;
            subtitleText = tProfileOverlaySubtitlePersonal;
            currentStepIndex = 0;
            stepperData[0] =
                stepperData[0].copyWith(status: StepStatus.inProgress);
            break;
          case ProfileSetupStep.academicFoundation:
            titleText = tOverlayAcademicTitle;
            subtitleText = tOverlayAcademicSubtitle;
            currentStepIndex = 1;
            stepperData[0] =
                stepperData[0].copyWith(status: StepStatus.completed);
            stepperData[1] =
                stepperData[1].copyWith(status: StepStatus.inProgress);
            break;
          case ProfileSetupStep.moduleSelection:
            titleText = tOverlayModulesTitle;
            subtitleText = tOverlayModulesSubtitle;
            currentStepIndex = 2;
            stepperData[0] =
                stepperData[0].copyWith(status: StepStatus.completed);
            stepperData[1] =
                stepperData[1].copyWith(status: StepStatus.completed);
            stepperData[2] =
                stepperData[2].copyWith(status: StepStatus.inProgress);
            break;
        }

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _pickProfileImage(context),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          colorScheme.surface.withValues(alpha: 0.2),
                      child: Icon(
                        Ionicons.camera_outline,
                        size: 36,
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  VSpace.sm,
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor:
                            colorScheme.onPrimary.withValues(alpha: 0.9)),
                    onPressed: () => _pickProfileImage(context),
                    child: const Text(tUploadProfilePicture),
                  ),
                  VSpace.med,
                  UiText(
                    text: titleText,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VSpace.sm,
                  UiText(
                    text: subtitleText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.85),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              VSpace.lg,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: StepperIndicator(
                  steps: stepperData,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.primary.withValues(alpha: 0.35),
                  completedTextColor: colorScheme.inverseSurface,
                  inProgressTextColor: AppTheme.infoColorDark,
                  pendingTextColor: colorScheme.primary.withValues(alpha: 0.6),
                  iconSize: IconSizes.lg,
                ),
              ),
              VSpace.lg,
              UiText(
                text:
                    "Step ${currentStepIndex + 1} of ${stepperData.length}: ${stepperData[currentStepIndex].title}",
                style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.7)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

extension StepDataUpdate on StepData {
  StepData copyWith(
      {String? title,
      StepStatus? status,
      IconData? completedIcon,
      IconData? inProgressIcon,
      IconData? pendingIcon}) {
    return StepData(
      title: title ?? this.title,
      status: status ?? this.status,
      completedIcon: completedIcon ?? this.completedIcon,
      inProgressIcon: inProgressIcon ?? this.inProgressIcon,
      pendingIcon: pendingIcon ?? this.pendingIcon,
    );
  }
}
