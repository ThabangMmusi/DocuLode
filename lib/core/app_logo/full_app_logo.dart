import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';

import '../../constants/app_text.dart';

class FullAppLogo extends StatelessWidget {
  const FullAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        tAppName,
        style: TextStyles.h2
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      Text(
        tAppVersion,
        style: TextStyles.body4,
      ),
    ]);
  }
}
