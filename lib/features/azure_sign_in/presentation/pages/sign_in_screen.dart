import 'dart:developer';

import 'package:doculode/config/index.dart';
import 'package:doculode/core/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_state.dart';
import '../widgets/steps/sign_in_content.dart';
import '../widgets/widgets.dart';

class SignInWithAzureScreen extends StatelessWidget {
  const SignInWithAzureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    log('SignInOtpScreen build called');
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        log('SignInOtpScreen BlocBuilder rebuild called');

        final double formPanelFraction = 0.55;
        final double overlayPanelFraction = 1.0 - formPanelFraction;

        final double formPanelWidth = screenSize.width * formPanelFraction;
        final double overlayPanelWidth =
            screenSize.width * overlayPanelFraction;

        const double cardBorderRadius = 0.0;
        final double morphingRadius = overlayPanelWidth * 0.1;

        BorderRadius overlayBorderRadius = BorderRadius.only(
          topRight: const Radius.circular(cardBorderRadius),
          bottomRight: const Radius.circular(cardBorderRadius),
          topLeft: Radius.circular(morphingRadius),
          bottomLeft: Radius.circular(morphingRadius),
        );

        return Scaffold(
          body: AppShell(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: formPanelWidth,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: formPanelWidth * 0.08,
                          vertical: Insets.xl),
                      child: SignInFormContent()),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: Insets.xxl),
                //   width: overlayPanelWidth,
                //   decoration: BoxDecoration(
                //       // color: Theme.of(context).colorScheme.primary,
                //       // borderRadius: overlayBorderRadius
                //       // border: Border(left: BorderSide(width: 4))
                //       ),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: overlayPanelWidth * 0.1, vertical: 0),
                //     child: const AnimatingMotivations(
                //       key: ValueKey('animating_motivations_overlay'),
                //     ),
                //   ),
                // ),
              
              ],
            ),
          ),
        );
      },
    );
  }
}
