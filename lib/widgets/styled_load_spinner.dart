import 'package:flutter/material.dart';

class StyledLoadSpinner extends StatelessWidget {
  const StyledLoadSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: colorScheme.tertiary,
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.inversePrimary),
        ));
  }
}
