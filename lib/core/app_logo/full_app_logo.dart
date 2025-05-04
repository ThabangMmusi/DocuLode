import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';

import '../../constants/app_text.dart';

class FullAppLogo extends StatelessWidget {
  /// A widget that displays the full app logo with the app name and version.
  ///
  /// The [showIconOnly] parameter determines whether to show only the icon or the full logo.
  /// By default, it is set to false, which means the full logo will be displayed.
  ///
  /// Example usage:
  /// ```dart
  /// FullAppLogo(showIconOnly: true)
  /// ```
final bool showIconOnly;
  const FullAppLogo({super.key, this.showIconOnly = false});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        tAppName,
        style: TextStyles.h2
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      if (!showIconOnly)
      Text(
        tAppVersion,
        style: TextStyles.body4,
      ),
    ]);
  }
}
