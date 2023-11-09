import 'dart:math';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class LoadingDataPage extends StatefulWidget {
  const LoadingDataPage({super.key});

  @override
  State<LoadingDataPage> createState() => _LoadingDataPageState();
}

class _LoadingDataPageState extends State<LoadingDataPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tSecondaryColor,
      body: Stack(
        children: [
          const Center(
            child: CircleAvatar(
              backgroundColor: tPrimaryColor,
              radius: 40,
              child: Icon(Icons.shopping_cart_outlined),
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
              child: const Center(
                child: GradientCircularProgressIndicator(
                  radius: 50,
                  gradientColors: [
                    tAccentColor,
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    Color.fromARGB(255, 190, 189, 215),
                    tAccentColor,
                  ],
                  strokeWidth: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  const GradientCircularProgressIndicator({super.key, 
    required this.radius,
    required this.gradientColors,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
        radius: radius,
        gradientColors: gradientColors,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.radius,
    required this.gradientColors,
    required this.strokeWidth,
  });
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double offset = strokeWidth / 2;
    Rect rect = Offset(offset, offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    Paint myCircle = Paint()
      ..color = const Color.fromARGB(255, 190, 189, 215)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // canvas.drawCircle(
    //   Offset(offset, offset),
    //   radius,
    //   myCircle,
    // );

    canvas.drawArc(rect, 0.0, 1, false, myCircle);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    paint.shader =
        SweepGradient(colors: gradientColors, startAngle: 0.0, endAngle: 2 * pi)
            .createShader(rect);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
