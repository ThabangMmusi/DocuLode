import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/ui_text.dart';

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
            style: TextStyles.body2.copyWith(color: Colors.black), text: text));
  }
}
