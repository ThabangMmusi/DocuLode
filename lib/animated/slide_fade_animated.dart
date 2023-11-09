import 'package:flutter/material.dart';

class SlideFadeAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final Axis axis;

  const SlideFadeAnimation({
    super.key,
    required this.animation,
    required this.child,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) =>
          animation.value == 0.0 ? Container() : child!,
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          axis: axis,
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}
