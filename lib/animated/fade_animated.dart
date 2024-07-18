import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const FadeAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) =>
          animation.value == 0.0 ? Container() : child!,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
