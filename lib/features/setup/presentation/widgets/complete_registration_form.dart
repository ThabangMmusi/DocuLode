import 'package:doculode/app/app.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/core/widgets/buttons/buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/constants/index.dart';
import '../bloc/setup_bloc.dart';
import 'widgets.dart';

class CompleteRegistrationForm extends StatelessWidget {
  const CompleteRegistrationForm({super.key});
  static const double _formMaxWidth = 420.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupState>(
      buildWhen: (prev, current) =>
          prev.currentFlow != current.currentFlow ||
          prev.activeOperation != current.activeOperation ||
          prev.operationStatus != current.operationStatus ||
          (current.currentFlow == SetupStep.personalDetails &&
              (prev.firstName != current.firstName ||
                  prev.firstNameError != current.firstNameError ||
                  prev.lastName != current.lastName ||
                  prev.lastNameError != current.lastNameError ||
                  prev.profileImageFile != current.profileImageFile ||
                  prev.profileImageError != current.profileImageError)) ||
          (current.currentFlow == SetupStep.academicFoundation &&
              (prev.availableCourses != current.availableCourses ||
                  prev.selectedCourse != current.selectedCourse ||
                  prev.selectedCourseError != current.selectedCourseError ||
                  prev.selectedYear != current.selectedYear ||
                  prev.selectedYearError != current.selectedYearError ||
                  prev.availableSemesters != current.availableSemesters ||
                  prev.selectedSemester != current.selectedSemester ||
                  prev.selectedSemesterError !=
                      current.selectedSemesterError)) ||
          (current.currentFlow == SetupStep.moduleSelection &&
              (prev.availableModulesByYear != current.availableModulesByYear ||
                  prev.selectedModulesByYear != current.selectedModulesByYear ||
                  prev.selectedModulesError != current.selectedModulesError)),
      builder: (context, state) {
        if (state.activeOperation == SetupOperation.submitting &&
            state.operationStatus == OperationStatus.success) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _formMaxWidth),
              child: SuccessView(
                headerText: tOtpVerifiedTitle,
                message: tRedirecting,
                onAnimationComplete: () {
                  context.go(Routes.home);
                },
              ),
            ),
          );
        }

        String headerText = "";
        String? subHeaderText;
        IconData? headerIcon;
        Widget currentStepContent;

        switch (state.currentFlow) {
          case SetupStep.personalDetails:
            headerText = tProfileSetupTitle;
            subHeaderText = tProfileSetupSubtitlePersonal;
            headerIcon = Ionicons.person_add_outline;
            currentStepContent = PersonalDetailsStepContent(state: state);
            break;
          case SetupStep.academicFoundation:
          final username = context.read<AuthBloc>().state.getSingleName;
            headerText = "$tWelcomeToProfileSetup${username.isEmpty? "": ", $username"}!";
            subHeaderText = tProfileSetupAcademicSubtitle;
            headerIcon = Ionicons.school_outline;
            currentStepContent = AcademicFoundationStepContent(state: state);
            break;
          default:
            headerText = tOverlayModulesTitle;
            subHeaderText = tOverlayModulesSubtitle;
            // headerIcon = Ionicons.list_circle_outline;
            currentStepContent = ModuleSelectionStepContent(state: state);
            break;
        }

        return AuthContainer(
            formMaxWidth: _formMaxWidth,
            headerText: headerText,
            subHeaderText: subHeaderText,
            headerIcon: headerIcon,
            currentStepContent: currentStepContent,
            onBackButtonPress: currentStepContent is ModuleSelectionStepContent ? () => context.read<SetupBloc>().add(
                                const ChangeTheStep(
                                    SetupStep.academicFoundation)): null,);
      },
    );
  }
}
