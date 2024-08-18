import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../themes.dart';
import 'raw_styled_btn.dart';

export 'raw_styled_btn.dart';

/// Accent colored btn (orange), wraps RawBtn
class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn(
      {super.key,
      required this.onPressed,
      this.label,
      this.icon,
      this.child,
      this.leadingIcon = false,
      this.isCompact = false,
      this.cornerRadius});
  final Widget? child;
  final String? label;
  final IconData? icon;
  final bool leadingIcon;
  final bool isCompact;
  final double? cornerRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawBtn(
      enableShadow: false,
      cornerRadius: cornerRadius,
      normalColors: BtnColors(bg: AppTheme.accent1, fg: AppTheme.surface1),
      hoverColors: BtnColors(bg: AppTheme.focus, fg: AppTheme.surface1),
      onPressed: onPressed,
      child: BtnContent(
          label: label,
          icon: icon,
          leadingIcon: leadingIcon,
          isCompact: isCompact,
          child: child),
    );
  }
}

/// Surface colors btn (white), wraps RawBtn
class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.child,
    this.leadingIcon = false,
    this.isCompact = false,
    this.cornerRadius,
  });
  final Widget? child;
  final String? label;
  final IconData? icon;
  final bool leadingIcon;
  final bool isCompact;
  final double? cornerRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget content = BtnContent(
        label: label,
        icon: icon,
        leadingIcon: leadingIcon,
        isCompact: isCompact,
        child: child);
    if (isCompact) {
      return RawBtn(
          cornerRadius: cornerRadius,
          enableShadow: false,
          normalColors: BtnColors(
              bg: AppTheme.bg1,
              fg: AppTheme.greyMedium,
              outline: AppTheme.greyWeak),
          hoverColors: BtnColors(
              bg: AppTheme.focus.withOpacity(.15),
              fg: AppTheme.focus,
              outline: AppTheme.focus),
          onPressed: onPressed,
          child: content);
    }
    return RawBtn(
      enableShadow: false,
      normalColors: BtnColors(
          bg: AppTheme.surface1,
          fg: AppTheme.accent1,
          outline: AppTheme.greyWeak),
      hoverColors: BtnColors(bg: AppTheme.bg1, fg: AppTheme.focus),
      onPressed: onPressed,
      child: content,
    );
  }
}

/// Takes any child, applies no padding, and falls back to default colors
class SimpleBtn extends StatelessWidget {
  const SimpleBtn(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.focusMargin,
      this.normalColors,
      this.hoverColors,
      this.cornerRadius,
      this.ignoreDensity})
      : super(key: key);
  final Widget child;
  final VoidCallback? onPressed;
  final double? focusMargin;
  final BtnColors? normalColors;
  final BtnColors? hoverColors;
  final double? cornerRadius;
  final bool? ignoreDensity;

  @override
  Widget build(BuildContext context) {
    return RawBtn(
      cornerRadius: cornerRadius,
      normalColors: normalColors,
      hoverColors: hoverColors,
      focusMargin: focusMargin ?? 0,
      enableShadow: false,
      onPressed: onPressed,
      ignoreDensity: ignoreDensity ?? true,
      child: child,
    );
  }
}

/// Text Btn - wraps a [SimpleBtn]
class TextBtn extends StatelessWidget {
  const TextBtn(this.label,
      {Key? key,
      required this.onPressed,
      this.isCompact = false,
      this.style,
      this.showUnderline = false})
      : super(key: key);
  final String label;
  final VoidCallback? onPressed;
  final bool isCompact;
  final TextStyle? style;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    TextStyle finalStyle = style ??
        TextStyles.caption.copyWith(
            decoration:
                showUnderline ? TextDecoration.underline : TextDecoration.none,
            fontWeight: FontWeight.w500);
    return SimpleBtn(
      ignoreDensity: false,
      onPressed: onPressed,
      child: Text(label, style: finalStyle),
    );
  }
}

/// Icon Btn - wraps a [SimpleBtn]
class IconBtn extends StatelessWidget {
  const IconBtn(this.icon,
      {Key? key,
      required this.onPressed,
      this.color,
      this.padding,
      this.ignoreDensity})
      : super(key: key);
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? padding;
  final bool? ignoreDensity;
  @override
  Widget build(BuildContext context) {
    // bool enableTouchMode = context.select((AppModel m) => m.enableTouchMode);
    // int extraPadding = enableTouchMode ? 3 : 0;
    return SimpleBtn(
        ignoreDensity: ignoreDensity,
        onPressed: onPressed,
        child: AnimatedPadding(
          duration: Times.fast,
          curve: Curves.easeOut,
          padding: padding ?? EdgeInsets.all(Insets.xs),
          // padding: padding ?? EdgeInsets.all(Insets.xs + extraPadding),
          child: Icon(icon, color: color ?? Colors.black, size: 20),
        ));
  }
}
