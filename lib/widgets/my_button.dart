import 'package:flutter/material.dart';

import '../styles.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {super.key,
      this.loading = false,
      required this.title,
      this.iconToRight = false,
      this.outline = false,
      required this.onTap,
      this.icon});
  final bool loading;
  final String title;
  final bool iconToRight;
  final bool outline;
  final Function() onTap;
  final IconData? icon;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
  }

  late Color primaryColor;
  late Color onPrimaryColor;
  late Color onSecondaryColor;
  late Color secondaryColor;
  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).colorScheme.primary;
    onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    onSecondaryColor = Theme.of(context).colorScheme.onSecondary;
    secondaryColor = Theme.of(context).colorScheme.secondary;
    return widget.loading
        ? Center(
            child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  backgroundColor: Colors.black12,
                )),
          )
        : InkWell(
            onHover: (value) => setState(() => _hovered = value),
            onTap: widget.onTap,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            borderRadius: Corners.medBorder,
            child: Container(
              height: 42,
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              decoration: BoxDecoration(
                  border:
                      widget.outline ? Border.all(color: primaryColor) : null,
                  borderRadius: Corners.medBorder,
                  color: _hovered
                      ? widget.outline
                          ? primaryColor.withAlpha(20)
                          : secondaryColor
                      : widget.outline
                          ? Colors.transparent
                          : primaryColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.iconToRight && widget.icon != null) ...[
                    buildIcon(),
                    HSpace.sm,
                  ],
                  Text(
                    widget.title,
                    textAlign: TextAlign.start,
                    style: TextStyles.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      color: widget.outline ? onSecondaryColor : onPrimaryColor,
                    ),
                  ),
                  if (widget.iconToRight) ...[
                    HSpace.sm,
                    buildIcon(),
                  ],
                ],
              ),
            ),
          );
  }

  Icon buildIcon() => Icon(
        widget.icon,
        color: widget.outline ? onSecondaryColor : onPrimaryColor,
      );
}
