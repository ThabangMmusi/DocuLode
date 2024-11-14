import 'package:flutter/material.dart';

import '../../../styles.dart';

class ViewTitle extends StatelessWidget {
  const ViewTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.h1,
    );
  }
}
