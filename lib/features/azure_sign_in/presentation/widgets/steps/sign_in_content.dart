import 'dart:ui';

import 'package:doculode/config/index.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/core/constants/app_enums.dart';
import 'package:doculode/core/constants/app_text.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../widgets/buttons/buttons.dart';
import '../../bloc/bloc.dart';
part 'microsoft_login_step.dart';
part 'browser_sign_in_step.dart';

class SignInFormContent extends StatelessWidget {
  const SignInFormContent({super.key});
  static const double _formMaxWidth = 360.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        // No SnackBar for OTP resend or errors
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (prev, current) =>
            prev.currentFlow != current.currentFlow ||
            prev.activeOperation != current.activeOperation ||
            prev.operationStatus != current.operationStatus ||
            prev.operationError != current.operationError,
        builder: (context, state) {
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;
          if (state.currentFlow == SignInFlow.otpVerified) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _formMaxWidth),
                child: SuccessView(
                    headerText: tAuthenticated, message: tRedirecting),
              ),
            );
          }


        String headerText = "";
        String? subHeaderText;
        IconData? headerIcon;
        Widget currentStepContent;

          if (state.currentFlow == SignInFlow.browserSignIn) {
            headerText = tBrowserSignInTitle;
            headerIcon = Ionicons.browsers_outline;

            currentStepContent = BrowserSignInStep(state: state);
          } else {
            headerText = tSignInTitle;
            subHeaderText = tSignInSubTitle;
            headerIcon = Ionicons.mail_outline;

            currentStepContent = MicrosoftLoginStep(state: state);
          }
          return AuthContainer(
            formMaxWidth: _formMaxWidth,
            headerText: headerText,
            subHeaderText: subHeaderText,
            headerIcon: headerIcon,
            currentStepContent: currentStepContent);
        },
      ),
    );
  }
}
