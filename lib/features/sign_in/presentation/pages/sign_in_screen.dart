import 'dart:developer';

import 'package:doculode/config/index.dart';
import 'package:doculode/core/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_state.dart';
import '../widgets/steps/sign_in_form_content.dart';
import '../widgets/widgets.dart';

class SignInOtpScreen extends StatefulWidget {
  const SignInOtpScreen({super.key});
  @override
  State<SignInOtpScreen> createState() => _SignInOtpScreenState();
}

class _SignInOtpScreenState extends State<SignInOtpScreen> {
  final Duration _animationDuration = const Duration(milliseconds: 1000);
  final Curve _animationCurve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    log('SignInOtpScreen initState called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('SignInOtpScreen first frame rendered');
    });
  }

  @override
  Widget build(BuildContext context) {
    log('SignInOtpScreen build called');
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        log('SignInOtpScreen BlocBuilder rebuild called');

        final bool isOverlayToTheRight = true;

        final double formPanelFraction = 0.55;
        final double overlayPanelFraction = 1.0 - formPanelFraction;

        final double formPanelWidth = screenSize.width * formPanelFraction;
        final double overlayPanelWidth =
            screenSize.width * overlayPanelFraction;

        const double cardBorderRadius = 0.0;
        final double morphingRadius = overlayPanelWidth * 0.3;

        BorderRadius overlayBorderRadius = BorderRadius.only(
          topRight: const Radius.circular(cardBorderRadius),
          bottomRight: const Radius.circular(cardBorderRadius),
          topLeft: Radius.circular(morphingRadius),
          bottomLeft: Radius.circular(morphingRadius),
        );

        return Scaffold(
          body: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(cardBorderRadius),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: formPanelWidth,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: formPanelWidth * 0.08,
                              vertical: Insets.xl),
                          child: const SignInFormContent()),
                    ),
                    SizedBox(
                      width: overlayPanelWidth,
                      child: Container(color: Colors.transparent),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  left: formPanelWidth - Insets.xl,
                  top: 0,
                  bottom: 0,
                  child: Hero(
                    tag: "auth_overlay_panel",
                    flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) {
                      return Material(
                          type: MaterialType.transparency,
                          child: toHeroContext.widget);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Insets.med),
                      child: AnimatedContainer(
                        duration: _animationDuration,
                        curve: _animationCurve,
                        width: overlayPanelWidth,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: overlayBorderRadius),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: overlayPanelWidth * 0.1,
                              vertical: Insets.xxxl),
                          child: const AnimatingMotivations(
                            key: ValueKey('animating_motivations_overlay'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Insets.xl,
                  left: Insets.xl,
                  child: AppLogo(variant: LogoVariant.horizontal,),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
