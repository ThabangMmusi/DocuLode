import 'package:doculode/config/index.dart';

import 'package:flutter/material.dart';

class BaseListItemWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget child;
  final bool showDivider;
  final bool isSelected;

  const BaseListItemWidget({
    super.key,
    required this.child,
    this.onPress,
    this.showDivider = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withOpacity(0.4)
          : Colors.transparent,
      borderRadius:
          Corners.smBorder, // Add some rounding to individual items if desired
      child: InkWell(
        onTap: onPress,
        borderRadius: Corners.smBorder,
        child: Container(
          height: Sizes.listItem,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: Insets.med),
          decoration: showDivider
              ? BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: theme.dividerColor.withOpacity(0.5))))
              : null,
          child: child,
        ),
      ),
    );
  }
}
