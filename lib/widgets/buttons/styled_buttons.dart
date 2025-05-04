import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../themes.dart';
import 'raw_styled_btn.dart';

export 'raw_styled_btn.dart';

/// Accent colored btn, wraps RawBtn
class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.child,
    this.leadingIcon = false,
    this.isCompact = false,
    this.cornerRadius,
    this.loading = false,
  });
  final Widget? child;
  final String? label;
  final IconData? icon;
  final bool leadingIcon;
  final bool isCompact;
  final double? cornerRadius;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return RawBtn(
      loading: loading,
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

/// Surface colors btn, wraps RawBtn
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
              bg: AppTheme.focus.withValues(alpha: .15),
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
      hoverColors: BtnColors(
        bg: AppTheme.bg1,
        fg: AppTheme.focus,
        outline: AppTheme.greyWeak,
      ),
      onPressed: onPressed,
      child: content,
    );
  }
}

/// Takes any child, applies no padding,
/// and falls back to default colors
class SimpleBtn extends StatelessWidget {
  const SimpleBtn(
      {super.key,
      required this.onPressed,
      required this.child,
      this.focusMargin,
      this.normalColors,
      this.hoverColors,
      this.cornerRadius,
      this.ignoreDensity});
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
      {super.key,
      required this.onPressed,
      this.isCompact = false,
      this.style,
      this.showUnderline = false});
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
    if (isCompact) {
      return SimpleBtn(
          ignoreDensity:false,
          onPressed: onPressed,
          cornerRadius: Insets.lg,
          normalColors: BtnColors(
              bg: Theme.of(context).colorScheme.surface,
              fg: Theme.of(context).colorScheme.onInverseSurface,
              outline:  Theme.of(context).colorScheme.tertiary,),
          hoverColors: BtnColors(
            bg:  Theme.of(context).colorScheme.onTertiaryContainer,
            fg:  Theme.of(context).colorScheme.onSurface,
            outline:  Theme.of(context).colorScheme.primary,
          ),
          child: AnimatedPadding(
            duration: Times.fast,
            curve: Curves.easeOut,
            padding:  EdgeInsets.all(Insets.xs),
            // padding: padding ?? EdgeInsets.all(Insets.xs + extraPadding),
      child: Text(label, style: finalStyle),
          ));
    }
    return  SimpleBtn(
      ignoreDensity: false,
      onPressed: onPressed,
      child: Text(label, style: finalStyle),
    );
  }
}

/// Icon Btn - wraps a [SimpleBtn]
class IconBtn extends StatelessWidget {
  const IconBtn(this.icon,
      {super.key,
      required this.onPressed,
      this.color,
      this.padding,
      this.ignoreDensity,
      this.compact = false});
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsets? padding;
  final bool? ignoreDensity;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    // bool enableTouchMode = context.select((AppModel m) => m.enableTouchMode);
    // int extraPadding = enableTouchMode ? 3 : 0;
    if (compact) {
      return SimpleBtn(
          ignoreDensity: ignoreDensity,
          onPressed: onPressed,
          normalColors: BtnColors(
              bg: Theme.of(context).colorScheme.surface,
              fg: Theme.of(context).colorScheme.onInverseSurface,
              outline:  Theme.of(context).colorScheme.tertiary,),
          hoverColors: BtnColors(
            bg:  Theme.of(context).colorScheme.onTertiaryContainer,
            fg:  Theme.of(context).colorScheme.onSurface,
            outline:  Theme.of(context).colorScheme.primary,
          ),
          child: AnimatedPadding(
            duration: Times.fast,
            curve: Curves.easeOut,
            padding: padding ?? EdgeInsets.all(Insets.xs),
            // padding: padding ?? EdgeInsets.all(Insets.xs + extraPadding),
            child: Icon(icon),
          ));
    }
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
class DeleteBtn extends StatelessWidget {
  const DeleteBtn({
    super.key, 
    required this.onPressed,
    this.label = 'Delete',
    this.icon = Icons.delete,
  });

  const DeleteBtn.TextOnly({
    super.key,
    required this.onPressed,
    this.label = 'Delete',
  }) : 
       icon = null;

  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Insets.med).copyWith(bottom: Insets.xs),
      child: RawBtn(
        padding: EdgeInsets.all(Insets.sm),
        normalColors: BtnColors(
          bg: Theme.of(context).colorScheme.errorContainer,
          fg: Theme.of(context).colorScheme.onErrorContainer,
        ),
        hoverColors: BtnColors(
          bg: Theme.of(context).colorScheme.primary,
          fg: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon!=null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}


class SelectableBtn extends StatelessWidget {
  const SelectableBtn(
      {super.key, required this.onPressed, required this.text, required this.selected});
  final bool selected;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RawBtn(
      padding: EdgeInsets.all(Insets.sm),
      enableShadow: false,
      normalColors: BtnColors(
        bg: selected
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.tertiary,
        fg: Theme.of(context).colorScheme.onPrimary,
      ),
      hoverColors: BtnColors(
        bg: Theme.of(context).colorScheme.primary,
        fg: Theme.of(context).colorScheme.onPrimary,
      ),
      cornerRadius: Insets.xl,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: selected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontSize: 14),
      ),
    );
  }
}
