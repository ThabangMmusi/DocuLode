import 'package:doculode/core/components/app_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: AppLogo(variant: LogoVariant.vertical, showSlogan: true),
        ),
      ),
    );
  }
}
