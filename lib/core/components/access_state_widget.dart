import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/styles.dart';

class AccessStateWidget extends StatelessWidget {
  const AccessStateWidget(
    this.access, {
    super.key,
  });
  final AccessType access;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Insets.sm),
        decoration: BoxDecoration(
            borderRadius: Corners.xlBorder,
            color: access == AccessType.public
                ? Colors.green[50]
                : Colors.red[50]),
        child: Icon(
          access == AccessType.public
              ? Ionicons.earth_outline
              : Ionicons.lock_closed_outline,
          size: 16,
          color: access == AccessType.public ? Colors.green : Colors.red,
        ));
  }
}
