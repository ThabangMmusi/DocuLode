import 'package:doculode/widgets/animated/animated.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';

class SlideFadeAnimParent extends StatefulWidget {
  const SlideFadeAnimParent({super.key, required this.child});
  final Widget child;
  @override
  State<SlideFadeAnimParent> createState() => _SlideFadeAnimParentState();
}

class _SlideFadeAnimParentState extends State<SlideFadeAnimParent>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(microseconds: 1));
    // _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    _animationController.value = 0;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animate();
    return SlideFadeAnimation(
        animation: _animationController, child: widget.child);
  }
}
