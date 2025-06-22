import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/widgets/index.dart';



















import 'package:flutter/material.dart';



class GrayRoundedText extends StatelessWidget {
  const GrayRoundedText(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
        decoration: const BoxDecoration(
            borderRadius: Corners.xlBorder, color: Colors.black12),
        child: UiText(
            style: TextStyles.bodyMedium.copyWith(color: Colors.black),
            text: text));
  }
}
