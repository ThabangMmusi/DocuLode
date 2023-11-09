import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class CategoryButton extends StatefulWidget {
  final int index;
  final String title;
  final VoidCallback? onPressed;
  final bool isSelected;

  const CategoryButton(
      {super.key,
      required this.index,
      required this.title,
      this.isSelected = false,
      this.onPressed});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  GlobalKey? _key;
  bool _hovered = false;

  @override
  void initState() {
    _key = LabeledGlobalKey("category_button");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _key,
      onHover: (value) => setState(() => _hovered = value),
      onTap: widget.onPressed,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(kPaddingHalf),
      child: Container(
        padding: const EdgeInsets.all(kPaddingHalf),
        decoration: BoxDecoration(
            border: Border.all(
                color: _hovered ? tPrimaryColor : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(kPaddingHalf),
            color: _hovered ? tPrimaryColor.withAlpha(100) : tWhiteColor),
        child: Center(child: Text(widget.title)),
      ),
    );
  }
}
