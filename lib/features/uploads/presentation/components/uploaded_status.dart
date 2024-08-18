import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';

// enum UploadedStatus {unpublished, published}
class UploadedStatus extends StatelessWidget {
  const UploadedStatus({super.key, this.published = false});
  final bool published;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm),
      decoration:
          BoxDecoration(borderRadius: Corners.xlBorder, color: Colors.red[50]),
      child: Center(
          child: Text(
        "Private",
        style: TextStyles.body4.copyWith(color: Colors.red),
      )),
    );
  }
}
