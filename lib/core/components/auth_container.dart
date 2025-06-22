import 'dart:ui';
import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/widgets/buttons/secondary_btn.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'auth_header.dart';

class AuthContainer extends StatelessWidget {
  final double formMaxWidth;
  final VoidCallback? onBackButtonPress;
  final String headerText;
  final String? subHeaderText;
  final IconData? headerIcon;
  final Widget currentStepContent;

  const AuthContainer({
    super.key,
    required this.formMaxWidth,
    required this.headerText,
    this.subHeaderText,
    this.headerIcon,
    required this.currentStepContent,
    this.onBackButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: formMaxWidth),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: ShadowAndGlassPainter(
                  shadowColor: Colors.black.withOpacity(0.35),
                  elevation: 30.0,
                  borderRadius: Corners.medBorder.topLeft,
                  glassColor: colorScheme.onPrimary.withValues(alpha: .9),
                  borderColor: colorScheme.tertiaryContainer,
                ),
              ),
              ClipRRect(
                borderRadius: Corners.medBorder,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 50,
                    sigmaY: 50,
                    tileMode: TileMode.repeated,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(Insets.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (onBackButtonPress != null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SecondaryBtn(
                                      isCompact: true,
                                      icon: Ionicons.chevron_back,
                                      onPressed: onBackButtonPress),
                                ],
                              ),
                              VSpace.lg
                            ],
                          ),
                        AuthHeader(
                            headerText: headerText,
                            subHeaderText: subHeaderText,
                            iconData: headerIcon),
                        VSpace.xl,
                        // FIX: By using SizeTransition within the builder, the AnimatedSwitcher
                        // now animates its own size along with its content. This is the correct
                        // way to handle content of different sizes and avoid overflow errors.
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            // Combine a size animation with the fade animation.
                            return SizeTransition(
                              axis: Axis.vertical, // Animate height
                              sizeFactor: animation, // Use the provided animation controller
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            // The key is CRITICAL. It tells AnimatedSwitcher that the widget has
                            // actually changed, triggering the transition.
                            key: ValueKey<String>(headerText),
                            child: currentStepContent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ShadowAndGlassPainter extends CustomPainter {
  ShadowAndGlassPainter({
    required this.shadowColor,
    required this.glassColor,
    required this.borderColor,
    required this.borderRadius,
    required this.elevation,
  });

  final Color shadowColor;
  final Color glassColor;
  final Color borderColor;
  final Radius borderRadius;
  final double elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderRadius,
    );

    final path = Path()..addRRect(rrect);

    canvas.drawShadow(path, shadowColor, elevation, false);

    final glassPaint = Paint()
      ..color = glassColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, glassPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant ShadowAndGlassPainter oldDelegate) {
    return oldDelegate.shadowColor != shadowColor ||
        oldDelegate.glassColor != glassColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.elevation != elevation;
  }
}