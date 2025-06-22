import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:doculode/core/constants/responsive.dart';
import 'package:doculode/app/config/styles.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({required this.title, this.leading, this.trailing});
  final String title;
  final Widget? leading;
  final Widget? trailing;

  final double minTopBarHeight = kToolbarHeight + Insets.lg + 2;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    var shrinkFactor = min(1, shrinkOffset / (minTopBarHeight - 1));
    var topBar = SizedBox(
      height: max(minTopBarHeight * (1 - shrinkFactor), minTopBarHeight),
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
                    color: colorScheme.tertiaryContainer.withValues(alpha: .1),
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
                    color: !Responsive.isMobile(context)
                        ? null
                        : Theme.of(context).colorScheme.surface,
                    border: shrinkFactor > .4
                        ? Border(
                            bottom: BorderSide(
                                color: colorScheme.tertiaryContainer,
                                width: 1.2))
                        : null),
              ),
            ),
          ),
          if (leading != null)
            Align(
              alignment: Alignment.centerLeft,
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
              width: 200,
              child: Opacity(
                opacity: min(1, (shrinkFactor) * 1),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyles.headlineMedium,
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
  double get maxExtent => minTopBarHeight;
  @override
  double get minExtent => minTopBarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
