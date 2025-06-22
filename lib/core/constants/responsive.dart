import 'package:doculode/app/config/index.dart';













import 'package:flutter/material.dart';


class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  static bool isMobile(context) => MediaQuery.of(context).size.width < 768;

  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  static double sidePadding(context) {
    if (isTablet(context)) {
      return Insets.lg;
    } else if (isMobile(context)) {
      return Insets.med;
    } else {
      return Insets.xl;
    }
  }

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    // If our width is more than 1100 then we consider it a desktop
    if (width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 768 we consider it as tablet
    else if (width >= 768) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
