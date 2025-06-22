import 'package:doculode/app/config/index.dart';

import 'package:flutter/material.dart';

// Assuming styles.dart is in this path

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.headerText,
    this.subHeaderText,
    this.iconData,
    this.iconSize = IconSizes.xl, // Default to new IconSizes.xl (40px)
  });

  final String headerText;
  final String? subHeaderText;
  final IconData? iconData;
  final double iconSize; // Made icon size configurable with a default

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200), // Or Times.fast
      transitionBuilder: (child, animation) {
        // Your chosen transition for the header (e.g., FadeTransition)
        return FadeTransition(
          opacity: animation,
          child: child, // The child will be the new AuthHeader instance
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconData != null) ...[
            Container(
              padding: EdgeInsets.all(Insets.sm), // 8px padding around icon
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: Corners.medBorder, 
                boxShadow: Shadows.medium,
              ),
              child: Icon(
                iconData, 
                size: iconSize, // Use the iconSize property
                color: colorScheme.inversePrimary,
              ),
            ),
            VSpace.lg, // 16px space
          ],
          //  if (iconData != null)
          // Container(
          //   width: 60,
          //   padding: EdgeInsets.all(Insets.sm), // 8px padding around icon
          //     decoration: BoxDecoration(
          //       color: colorScheme.primary,
          //       borderRadius: Corners.medBorder, // 12px radius
          //     ),
          // child: 
          // AppLogo(variant: LogoVariant.logoOnly),
          // ),
          // VSpace.xxl, 
          Text(
            headerText,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900, // Keeping this as per original
              // Consider if TextStyles.headlineMedium from your theme setup already has desired weight
              color: colorScheme.onSurface, // Explicitly set for clarity
            ),
          ),

          if (subHeaderText != null) ...[
            VSpace.sm,
            Text(
              subHeaderText!,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant, // Theme-aware color
                // fontSize: 13, // bodyMedium is typically 14px. If 13px is essential,
                // you might consider a custom TextStyle or TextStyles.bodySmall (12px)
                // or TextStyles.labelMedium (12px)
              ),
            ),
          ],
        ],
      ),
    );
  }
}
