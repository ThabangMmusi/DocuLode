import 'package:flutter/material.dart';
import 'package:doculode/config/styles.dart';
import 'package:doculode/core/constants/app_constants.dart';

import 'decorated_container.dart';

class StyledBottomSheet extends StatelessWidget {
  const StyledBottomSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
            top: Corners.medRadius, bottom: Radius.zero),
        color: theme.surface,
      ),
      child: Column(children: [
        VSpace.sm,

        /// Drag Handle
        DecoratedContainer(
          width: 96,
          height: 4,
          borderRadius: Corners.med,
          color: theme.tertiaryContainer,
        ),

        /// Content
        child
      ]),
    );
  }
}

Future<void> showStyledBottomSheet<T>(BuildContext context,
    {required Widget child}) async {
  return showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Corners.medRadius, bottom: Radius.zero),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            StyledBottomSheet(child: child),
          ],
        );
      });
}
