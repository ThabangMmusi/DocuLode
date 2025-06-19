import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_header.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({
    super.key,
    required this.headerText,
    required this.message,
    this.onAnimationComplete,
    this.iconBackgroundColor,
    this.iconColor,
    this.iconSize = 64.0,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.autoDismissDuration,
  });

  final String message;
  final String headerText;
  final VoidCallback? onAnimationComplete;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final double iconSize;
  final Duration animationDuration;
  final Duration? autoDismissDuration;

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    HapticFeedback.mediumImpact();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _iconScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    _iconOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.8, curve: Curves.easeOutCubic),
      ),
    );
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.7, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
        if (widget.autoDismissDuration != null && mounted) {
          Future.delayed(widget.autoDismissDuration!, () {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final actualIconBackgroundColor =
        widget.iconBackgroundColor ?? colorScheme.primary;

    final actualIconColor = widget.iconColor ?? colorScheme.onPrimary;

    final Color finalIconColor = (actualIconColor == actualIconBackgroundColor)
        ? (ThemeData.estimateBrightnessForColor(actualIconBackgroundColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black)
        : actualIconColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          key: const ValueKey('pop_success_view'),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _iconScaleAnimation,
              child: AnimatedOpacity(
                opacity: _iconOpacityAnimation.value,
                duration: Duration.zero,
                child: Container(
                  padding: EdgeInsets.all(widget.iconSize * 0.25),
                  decoration: BoxDecoration(
                    color: actualIconBackgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.25),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: finalIconColor,
                    size: widget.iconSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.iconSize * 0.5),
            SlideTransition(
              position: _textSlideAnimation,
              child: AnimatedOpacity(
                opacity: _textOpacityAnimation.value,
                duration: Duration.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AuthHeader(
                    headerText: widget.headerText,
                    subHeaderText: widget.message,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
