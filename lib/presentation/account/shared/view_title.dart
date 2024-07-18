import 'package:flutter/material.dart';
import 'package:its_shared/animated/animated.dart';

import '../../../styles.dart';

class ViewTitle extends StatefulWidget {
  const ViewTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<ViewTitle> createState() => _ViewTitleState();
}

class _ViewTitleState extends State<ViewTitle> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late var _key;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(microseconds: 1));
    _key = LabeledGlobalKey("button_icon");
    animate();
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
      key: _key,
      animation: _animationController,
      child: Text(
        widget.title,
        style: TextStyles.h1,
      ),
    );
  }
}
