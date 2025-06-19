import 'package:doculode/config/index.dart';

import 'package:flutter/material.dart';

import 'package:doculode/core/core.dart';

// enum UploadedStatus {unpublished, published}
class UploadedStatus extends StatelessWidget {
  const UploadedStatus(
    this.status, {
    super.key,
  });
  final AccessType status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm),
      decoration: BoxDecoration(
          borderRadius: Corners.xlBorder, color: getColor().withAlpha(50)),
      child: Center(
          child: Text(
        status.asString,
        style: TextStyles.labelSmall.copyWith(color: getForeColor()),
      )),
    );
  }

  Color getColor() {
    bool public = status == AccessType.public;
    return public ? Colors.greenAccent : Colors.red;
  }

  Color getForeColor() {
    bool public = status == AccessType.public;
    return public ? Colors.green[900]! : Colors.red;
  }
}
