import 'package:doculode/app/config/index.dart';













// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';



class DlTableIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const DlTableIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SizedBox(
      height: 32,
      width: 32,
      child: _DLButton(
          Icon(
            icon,
            color: colorScheme.tertiary,
            size: 16,
          ),
          padding: EdgeInsets.all(Insets.xs),
          onPressed: onPressed,
          // fillColor: colorScheme.primary,
          hoverFillColor: colorScheme.onPrimary),
    );
  }
}

class DlIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final EdgeInsets? padding;
  final Color? hoverFillColor;
  final Color? iconColor;
  const DlIconButton(
      {super.key,
      this.size = 32,
      this.iconSize = 16,
      this.padding,
      this.hoverFillColor,
      this.iconColor,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SizedBox(
      height: size,
      width: size,
      child: _DLButton(
          Icon(
            icon,
            color: iconColor ?? colorScheme.onPrimary,
            size: iconSize,
          ),
          padding: padding ?? EdgeInsets.all(Insets.xs),
          onPressed: onPressed,
          // fillColor: colorScheme.primary,
          hoverFillColor: hoverFillColor ?? colorScheme.primaryContainer),
    );
  }
}

class DLFilledButton extends StatelessWidget {
  const DLFilledButton(this.title,
      {super.key, required this.onPressed, this.icon});
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return _DLButton(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: colorScheme.onPrimary),
              HSpace.sm,
            ],
            Text(
              title,
              style:
                  TextStyles.bodyMedium.copyWith(color: colorScheme.onPrimary),
            )
          ],
        ),
        onPressed: onPressed,
        fillColor: colorScheme.primary,
        hoverFillColor: colorScheme.primaryContainer);
  }
}

class _DLButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color hoverFillColor;
  final Color? fillColor;
  final Color? hoverBorderColor;
  final Color? borderColor;
  final EdgeInsets? padding;

  const _DLButton(
    this.child, {
    required this.onPressed,
    required this.hoverFillColor,
    this.fillColor,
    this.padding,
    this.hoverBorderColor,
    this.borderColor,
  });

  @override
  State<_DLButton> createState() => _DLButtonState();
}

class _DLButtonState extends State<_DLButton> {
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = Corners.xlBorder;
    final padding = widget.padding ??
        EdgeInsets.symmetric(horizontal: Insets.med, vertical: 0);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 32),
      child: InkWell(
        onHover: (value) => setState(() => _hovered = value),
        onTap: widget.onPressed,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              border:
                  widget.borderColor != null && widget.hoverBorderColor != null
                      ? Border.all(
                          color: _hovered
                              ? widget.hoverBorderColor!
                              : widget.borderColor!)
                      : null,
              borderRadius: borderRadius,
              color: _hovered
                  ? widget.hoverFillColor
                  : widget.fillColor ?? Colors.transparent),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
