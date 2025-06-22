import 'package:doculode/app/config/index.dart';













 // Assuming your styles.dart path
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; // Assuming you use Ionicons

class AuthOptionButton extends StatelessWidget {
  final String label;
  final IconData? iconData; // Made iconData optional
  final Widget? iconWidget; // Allow passing a custom icon widget
  final VoidCallback onPressed;
  final bool isGoogle;
  final ButtonStyle? style; // Allow passing custom style to override theme

  const AuthOptionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconData,
    this.iconWidget,
    this.isGoogle = false,
    this.style,
  }) : assert(iconData != null || iconWidget != null || isGoogle,
            'Either iconData, iconWidget must be provided, or isGoogle must be true.');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // The base style comes from AppTheme.dart's outlinedButtonTheme
    // Specific overrides can be done via the 'style' parameter or direct properties.

    Widget finalIcon;
    if (isGoogle) {
      finalIcon = Icon(
        Ionicons.logo_google,
        size: IconSizes.med, // Using IconSizes from styles.dart
        // Color will be inherited from OutlinedButton's foregroundColor
      );
    } else if (iconWidget != null) {
      finalIcon = iconWidget!;
    } else {
      finalIcon = Icon(
        iconData,
        size: IconSizes.med, // Using IconSizes from styles.dart
      );
    }

    // Merge theme style with provided style
    final ButtonStyle? themeStyle = theme.outlinedButtonTheme.style;
    final ButtonStyle effectiveStyle =
        themeStyle?.merge(style) ?? style ?? const ButtonStyle();

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: finalIcon,
        label: Text(label), // Text style will come from outlinedButtonTheme
        onPressed: onPressed,
        style: effectiveStyle.copyWith(
            // Example of a specific override if needed,
            // but prefer defining in AppTheme.dart's outlinedButtonTheme.
            // For instance, if this button ALWAYS needs larger padding:
            // padding: MaterialStateProperty.all(
            //   EdgeInsets.symmetric(vertical: Insets.lg, horizontal: Insets.xl),
            // ),
            ),
      ),
    );
  }
}
