import 'package:flutter/material.dart';

class TextWithLink extends StatelessWidget {
  const TextWithLink({
    super.key,
    required this.onTap,
    required this.leftText,
    required this.linkText,
  });

  final VoidCallback? onTap;
  final String leftText, linkText;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leftText, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        GestureDetector(
          onTap: onTap,
          child: Text(linkText,
              style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        )
      ],
    );
  }
}
