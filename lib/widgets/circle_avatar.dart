import 'package:flutter/material.dart';

import 'decorated_container.dart';

class StyledCircleImage extends StatelessWidget {
  const StyledCircleImage({super.key, required this.url, this.padding});

  final EdgeInsets? padding;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedContainer(
          clipChild: true,
          borderColor: Theme.of(context).colorScheme.inversePrimary,
          borderWidth: 2,
          borderRadius: 99,
          child: Image.asset("name"),
        ),
      ),
    );
  }
}
