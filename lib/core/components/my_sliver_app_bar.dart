import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../styles.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar(
      {required this.minTopBarHeight,
      required this.maxTopBarHeight,
      required this.title,
      this.leading,
      this.trailing});
  final double minTopBarHeight;
  final double maxTopBarHeight;
  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    var shrinkFactor = min(1, shrinkOffset / (maxTopBarHeight - 1));
    var topBar = SizedBox(
      height: max(maxTopBarHeight * (1 - shrinkFactor), maxTopBarHeight),
      child: Stack(
        children: [
          Opacity(
            opacity: shrinkFactor > 0.0 ? 1 : 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 50, sigmaY: 50, tileMode: TileMode.repeated),
                child: ClipRect(
                  child: Container(
                    color: colorScheme.tertiaryContainer.withOpacity(.1),
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: shrinkFactor > 0.0 ? 1 : 0,
            child: ClipRect(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: colorScheme.tertiaryContainer, width: 1.2))),
              ),
            ),
          ),
          if (leading != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(Insets.lg),
                child: leading,
              ),
            ),
          if (trailing != null)
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [const Spacer(), trailing!, HSpace.lg, HSpace.sm],
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50 * min(1, (shrinkFactor) * 1),
              child: Opacity(
                opacity: min(1, (shrinkFactor) * 1),
                child: Text(
                  title,
                  style: TextStyles.h2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return topBar;
  }

  @override
  double get maxExtent => maxTopBarHeight;
  @override
  double get minExtent => minTopBarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
