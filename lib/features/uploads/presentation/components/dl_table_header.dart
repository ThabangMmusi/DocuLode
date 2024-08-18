import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../styles.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.child,
    this.backColor,
  });
  final PreferredSize child;
  final Color? backColor;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // var shrinkFactor =
    //     min(0, effectiveShrinkOffset / (child.preferredSize.height - 1));
    var shrinkFactor = min(1, shrinkOffset / (child.preferredSize.height - 1));
    Color bgColor = shrinkFactor == 1
        ? (Colors.black)
        : (Theme.of(context).colorScheme.onSecondary);
    print("shrinkOffset: $shrinkOffset");
    print("shrinkFactor: $shrinkFactor");
    return SizedBox.expand(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: Insets.xl + Insets.sm),
            margin: EdgeInsets.only(bottom: Insets.xs),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.tertiaryContainer),
              ),
            ),
            child: child));
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
