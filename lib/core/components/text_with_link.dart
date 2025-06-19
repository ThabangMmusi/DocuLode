import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that displays two pieces of text side-by-side using [RichText].
///
/// The [leftText] is displayed first, followed by the [rightText].
///
/// If an [onTap] callback is provided, the [rightText] is styled as an
/// interactive link (typically with primary color and underline) and becomes tappable.
///
/// If [onTap] is `null`, the [rightText] is styled as emphasized informational
/// text (typically bold, using the same base color as [leftText] or a standard
/// onSurface color, depending on provided styles).
class TextWithLink extends StatelessWidget {
  const TextWithLink({
    super.key,
    required this.leftText,
    required this.rightText,
    this.onTap,
    this.leftTextStyle,
    this.rightTextStyle, // Style for the rightText, overrides default behavior
    this.textAlign = TextAlign.center,
  });

  /// The text displayed on the left side.
  final String leftText;

  /// The text displayed on the right side. This text's styling and
  /// interactivity depend on the [onTap] callback and [rightTextStyle].
  final String rightText;

  /// Callback to be executed when the [rightText] is tapped.
  /// If `null`, the [rightText] will not be interactive and will be styled
  /// as emphasized informational text rather than a link.
  final VoidCallback? onTap;

  /// Optional [TextStyle] for the [leftText].
  /// Defaults to `Theme.of(context).textTheme.bodyMedium` with
  /// `colorScheme.onSurfaceVariant`.
  final TextStyle? leftTextStyle;

  /// Optional [TextStyle] for the [rightText].
  /// If provided, this style will be used directly for the [rightText].
  /// If `null`, the style is determined automatically:
  /// - If [onTap] is provided, it's styled as a link.
  /// - If [onTap] is `null`, it's styled as bold informational text.
  final TextStyle? rightTextStyle;

  /// How the text should be aligned horizontally. Defaults to [TextAlign.center].
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    // Style for the left (standard) part of the text
    final TextStyle effectiveLeftTextStyle = leftTextStyle ??
        textTheme.bodyMedium!.copyWith(
          color: colorScheme.onSurfaceVariant,
        );

    // Determine the style for the right part of the text
    TextStyle effectiveRightTextStyle;
    TapGestureRecognizer? recognizer;

    if (rightTextStyle != null) {
      // If a specific style is provided for the right text, use it.
      // If onTap is also present, make it tappable with the custom style.
      effectiveRightTextStyle = rightTextStyle!;
      if (onTap != null) {
        recognizer = TapGestureRecognizer()..onTap = onTap;
      }
    } else if (onTap != null) {
      // Style as a clickable link
      effectiveRightTextStyle = textTheme.bodyMedium!.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w700,
        // decoration: TextDecoration.underline,
        decorationColor: colorScheme.primary,
        // decorationThickness: 1.5,
      );
      recognizer = TapGestureRecognizer()..onTap = onTap;
    } else {
      // Style as non-clickable, emphasized informational text (e.g., bold)
      // It will inherit the color from effectiveLeftTextStyle if not overridden,
      // or use onSurface for a bit more pop.
      effectiveRightTextStyle = (effectiveLeftTextStyle).copyWith(
        // Inherit color from left text style, but make it bold.
        // Or, for more prominence: color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      );
    }

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: effectiveLeftTextStyle, // Base style for the entire RichText
        children: <TextSpan>[
          TextSpan(text: leftText.isNotEmpty ? '$leftText ' : leftText),
          TextSpan(
            text: rightText,
            style: effectiveRightTextStyle,
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
