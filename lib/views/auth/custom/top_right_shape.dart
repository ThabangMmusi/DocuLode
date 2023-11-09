import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AuthShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = tAccentColor;
    Path path = Path();
    path.lineTo(0, 0);
    //Use the method conicTo
    path.conicTo(size.width / 1.2, size.height, size.width,
        size.height - size.height / 5, 15);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AuthShapePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = tAccentColor;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width * .313, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
