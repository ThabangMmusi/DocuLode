import 'package:doculode/app/config/index.dart';













import 'package:flutter/material.dart';


class RoundContainer extends StatelessWidget {
  const RoundContainer(
      {super.key,
      this.padding,
      this.borderRadius,
      this.color,
      required this.child});
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    EdgeInsets dPadding = padding ?? EdgeInsets.all(Insets.med);
    BorderRadius dBorderRadius = borderRadius ?? Corners.lgBorder;
    return Container(
      padding: dPadding,
      decoration: BoxDecoration(borderRadius: dBorderRadius, color: color),
    );
  }
}
