import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/setup_bloc.dart';
import '../widgets/animating_motivations.dart';
import '../widgets/overlay_content.dart';
import '../widgets/setup_profile_content.dart';
import '../widgets/setup_academic_content.dart';

class SetupPageNew extends StatelessWidget {
  const SetupPageNew({super.key});

  final Duration _animationDuration = const Duration(milliseconds: 600);
  final Curve _animationCurve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        final bool isSignUpActive = state.formType == SetupType.academics;
        final double cardWidth = screenSize.width;
        final double cardHeight = screenSize.height;
        final double overlayPanelWidth = cardWidth / 2;
        const double cardBorderRadius = 0.0;
        final double morphingRadius = overlayPanelWidth;

        BorderRadius overlayBorderRadius = isSignUpActive
            ? BorderRadius.only(
                topLeft: const Radius.circular(cardBorderRadius),
                bottomLeft: const Radius.circular(cardBorderRadius),
                topRight: Radius.circular(morphingRadius),
                bottomRight: Radius.circular(morphingRadius),
              )
            : BorderRadius.only(
                topRight: const Radius.circular(cardBorderRadius),
                bottomRight: const Radius.circular(cardBorderRadius),
                topLeft: Radius.circular(morphingRadius),
                bottomLeft: Radius.circular(morphingRadius),
              );

        return Scaffold(
          body: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(cardBorderRadius),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: isSignUpActive ? 0.0 : 1.0,
                        duration: _animationDuration,
                        curve: _animationCurve,
                        child: IgnorePointer(
                            ignoring: isSignUpActive,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardWidth * 0.05,
                                    vertical: 20.0),
                                child: const SetupProfileContent())),
                      ),
                    ),
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: isSignUpActive ? 1.0 : 0.0,
                        duration: _animationDuration,
                        curve: _animationCurve,
                        child: IgnorePointer(
                            ignoring: !isSignUpActive,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardWidth * 0.05,
                                    vertical: 20.0),
                                child: const SetupAcademicContent())),
                      ),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  left: isSignUpActive ? 0 : overlayPanelWidth,
                  top: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: _animationDuration,
                    curve: _animationCurve,
                    width: overlayPanelWidth,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: overlayBorderRadius),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: overlayPanelWidth * 0.1, vertical: 40.0),
                      child: AnimatedSwitcher(
                        duration: Duration(
                            milliseconds:
                                _animationDuration.inMilliseconds ~/ 1.5),
                        transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(
                                            0,
                                            child.key ==
                                                    ValueKey(
                                                        'overlay_content_${isSignUpActive}')
                                                ? 0.05
                                                : -0.05),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: child)),
                        child: !isSignUpActive
                            ? Row(
                                children: [
                                  Expanded(
                                    child: IgnorePointer(
                                        ignoring: !isSignUpActive,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 20.0),
                                          child: AnimatingMotivations(),
                                        )),
                                  ),
                                ],
                              )
                            : const OverlayContent(
                                key: ValueKey('overlay_content_false'),
                                title: 'Welcome Back!',
                                description:
                                    'To keep connected with us please login with your personal info',
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
