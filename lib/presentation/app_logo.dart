import 'package:flutter/material.dart';

import '../constants/app_text.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.showSlogan = true,
  });
  final bool showSlogan;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   "assets/logos/logo.png", // replace with the actual path and name of your image file
        //   fit: BoxFit.cover,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        Text(
          tAppName,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        if (showSlogan)
          Text(
            tAppSlogan,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withValues(alpha: .5),
                fontSize: 14),
          ),
      ],
    );
  }
}
