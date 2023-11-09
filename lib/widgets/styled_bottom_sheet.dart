import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../styles.dart';

class StyledBottomSheet extends StatelessWidget {
  const StyledBottomSheet({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
            top: Corners.medRadius, bottom: Radius.zero),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(children: [
        kVSpacingQuarter,

        /// Drag Handle
        // DecoratedContainer(
        //   width: 96,
        //   height: 4,
        //   borderRadius: Corners.med,
        //   color: Theme.of(context).colorScheme.surface,
        // ),

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
