import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/constants/responsive.dart';
import 'package:doculode/core/data/models/src/app_stats_model.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/core/widgets/buttons/buttons.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/stats/stats_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  SliverPersistentHeader makeAppBar() {
    return SliverPersistentHeader(
      floating: true,
      delegate: _SliverAppBarDelegate(
        child: const PreferredSize(
            preferredSize: Size.fromHeight(65), child: _AppBar()),
      ),
    );
  }

  SliverPersistentHeader searchAppBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        child: PreferredSize(
            preferredSize: Size.fromHeight(40 + Insets.xl),
            child: Padding(
              padding: EdgeInsets.all(Insets.lg),
              child: const SearchButton(),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            pinned: true, delegate: MySliverAppBar(title: "Dashboard")),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                "Hi..👋, Thabang Mmusi",
                style: TextStyles.displayLarge,
              ),
              PrimaryBtn(onPressed: () {
                context.go("/shared/454454");
              }),
              SizedBox(height: Responsive.sidePadding(context)),
              searchBar(context),
              SizedBox(height: Responsive.sidePadding(context)),
              Padding(
                padding: EdgeInsets.only(left: Insets.xl, bottom: Insets.lg),
                child: Row(
                  children: [
                    Text(
                      "Recently Uploaded",
                      style: TextStyles.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: responsiveStatsBuilder(context)),
      ],
    );
  }

  ConstrainedBox searchBar(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 42, maxWidth: 540),
      child: SearchAnchor.bar(
          barBackgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.tertiaryContainer),
          barElevation: WidgetStateProperty.all(0),
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
              );
            });
          }),
    );
  }

  Widget responsiveStatsBuilder(BuildContext context) {
    final items = tempStats();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg + Insets.xs),
      child: Column(
        children: [
          if (!Responsive.isMobile(context))
            statsBuilder(items, context)
          else ...[
            statsBuilder(items.sublist(0, 2), context),
            SizedBox(height: Responsive.sidePadding(context)),
            statsBuilder(items.sublist(2), context)
          ],
        ],
      ),
    );
  }

  Row statsBuilder(List<AppStatsModel> items, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        items.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.med),
            child: StatisticsWidgetNew(
              title: items[index].title!,
              value: NumberFormat.compact().format(items[index].counts),
              icon: items[index].icon!,
              bgColor: items[index].color!,
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Insets.lg).copyWith(bottom: 0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            child: Icon(Ionicons.person),
          ),
          HSpace.med,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi..👋",
                style: TextStyles.headlineSmall
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                "Thabang Mmusi",
                style: TextStyles.headlineMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SearchButtonNative extends StatefulWidget {
  const SearchButtonNative({
    super.key,
    required this.onTap,
  });
  final VoidCallback? onTap;

  @override
  State<SearchButtonNative> createState() => _SearchButtonNativeState();
}

class _SearchButtonNativeState extends State<SearchButtonNative> {
  String hint = "What event are you looking for?";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SearchAnchor(
      viewSurfaceTintColor: colorScheme.onSecondary,
      viewHintText: hint,
      viewLeading: Row(
        children: [
          const BackButton(),
          searchIcon(theme),
        ],
      ),
      builder: (BuildContext context, SearchController controller) {
        return Container(
          width: double.infinity,
          height: 60,
          padding:
              EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.med),
          decoration: BoxDecoration(
              color: colorScheme.surface, borderRadius: Corners.medBorder),
          child: Row(children: [
            searchIcon(theme),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Text(
                hint,
                style: TextStyles.bodyMedium,
              ),
            )
          ]),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      },
    );
  }

  Icon searchIcon(ThemeData theme) {
    return Icon(Ionicons.search_outline,
        size: 19, color: theme.colorScheme.onPrimaryContainer);
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Hero(
      tag: "search_event",
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(
                vertical: Insets.sm, horizontal: Insets.med),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: Corners.medBorder),
            child: Row(children: [
              Icon(Ionicons.search_outline,
                  size: 19, color: theme.colorScheme.onPrimaryContainer),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: Text(
                  "What event are you looking for?",
                  style: TextStyles.bodyMedium,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
  });
  final PreferredSize child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Color bgColor = Theme.of(context).colorScheme.onSecondary;
    return SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: bgColor,
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: child));
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class KSliverAppbar extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 100;
  final double maxTopBarHeight = 320;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? child;
  KSliverAppbar({
    required this.title,
    this.leading,
    this.subtitle,
    this.icon,
    this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));
    Widget finalLeading = leading ?? const BackButton(color: Colors.white);
    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height: max(maxTopBarHeight * (1 - shrinkFactor), minTopBarHeight),
        width: 100,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 10.0,
                color: Colors.green.withValues(alpha: 0.3),
              )
            ]),
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8 * 1.5),
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:
                      Colors.amberAccent.withValues(alpha: (shrinkFactor) * 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(26),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        finalLeading,
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(title,
                            style: TextStyles.titleLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(subtitle ?? "",
                            style: TextStyles.bodyMedium.copyWith(
                                color: Colors.white
                                    .withValues(alpha: (shrinkFactor) * 1),
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: max(26.0 * (1 - shrinkFactor), 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return SizedBox(
      height: max(maxExtent - shrinkOffset, minExtent),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withValues(alpha: 1.0 - shrinkFactor),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 10.0,
                        color: Colors.green
                            .withValues(alpha: 0.23 - (0.23 * shrinkFactor)),
                      )
                    ]),
                child:
                    AbsorbPointer(absorbing: shrinkFactor > 0.5, child: child),
              ),
            ),
          ),
          if (shrinkFactor > 0.5) topBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxTopBarHeight;
  @override
  double get minExtent => minTopBarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
