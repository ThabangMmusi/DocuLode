import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLogo2(context),
    );
  }

  Widget _buildLogo2(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 2.25),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            tAppName,
            style: TextStyles.h2
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            tAppVersion,
            style: TextStyles.body2.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w300),
          ),
        ]),
      ),
    );
  }
}
