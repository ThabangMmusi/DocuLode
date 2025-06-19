import 'package:doculode/config/index.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/core/constants/app_enums.dart';
import 'package:doculode/core/constants/app_text.dart';
import 'package:doculode/widgets/index.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../widgets/buttons/buttons.dart';
import '../../bloc/bloc.dart';
part 'email_step.dart';
part 'otp_step.dart';

class SignInFormContent extends StatelessWidget {
  const SignInFormContent({super.key});
  static const double _formMaxWidth = 380.0;

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
            prev.email != current.email ||
            prev.emailError != current.emailError ||
            prev.otp != current.otp ||
            prev.otpInputError != current.otpInputError ||
            prev.operationError != current.operationError,
        builder: (context, state) {
          Widget? infoMessage;
          if (state.activeOperation == SignInOperation.resendingOtp &&
              state.operationStatus == OperationStatus.success) {
            infoMessage =
                MessageContainer.info("Verifications has been resent to ${state.email}");
          }

          if (state.currentFlow == SignInFlow.otpVerified) {
            bool isLoadingUserStatusCheck =
                state.activeOperation == SignInOperation.checkingUserStatus &&
                    state.operationStatus == OperationStatus.inProgress;
            bool userStatusCheckDone =
                state.activeOperation == SignInOperation.none &&
                    state.operationStatus == OperationStatus.success &&
                    state.currentFlow == SignInFlow.otpVerified;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _formMaxWidth),
                child: SuccessView(
                  headerText: tAuthenticated,
                  message: isLoadingUserStatusCheck
                      ? tFetchingAccountDetails
                      : (userStatusCheckDone
                          ? tRedirecting
                          : tFetchingAccountDetails),
                  onAnimationComplete: () {
                    print("SignInFormContent: SuccessView animation complete.");
                  },
                ),
              ),
            );
          }

            Widget currentFormSubView;
            AuthHeader header;

            if (state.currentFlow == SignInFlow.otpInput) {
              header = AuthHeader(
                  iconData: Ionicons.lock_closed_outline,
                  headerText: tVerificationTitle);
              currentFormSubView = OtpStep(state: state);
            } else {
              header = AuthHeader(
                  iconData: Ionicons.mail_outline,
                  headerText: tEmail,
                  subHeaderText: tEmailHint);
              currentFormSubView = EmailStep(state: state);
            }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _formMaxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  if (infoMessage != null) ...[
                    VSpace.sm,
                    infoMessage,
                  ],
                  VSpace.med,
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      final slide = Tween<Offset>(
                              begin: const Offset(0.0, 0.03), end: Offset.zero)
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.easeInOutCubic));
                      return FadeTransition(
                          opacity: animation,
                          child:
                              SlideTransition(position: slide, child: child));
                    },
                    child: currentFormSubView,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
