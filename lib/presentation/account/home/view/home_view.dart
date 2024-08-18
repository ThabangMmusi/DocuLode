import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../constants/responsive.dart';
import '../../../../core/common/models/app_stats_model.dart';
import '../../../../core/core.dart';
import '../../../../styles.dart';
import '../../shared/shared.dart';
import '../../home/home.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
    // this.backColor
  });
  final PreferredSize child;
  // final Color? backColor;
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
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });
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
    double minTopBarHeight = kToolbarHeight + Insets.lg + 2;
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(
                title: "Dashboard",
                minTopBarHeight: minTopBarHeight,
                maxTopBarHeight: minTopBarHeight)
            // delegate: kSliverAppbar(title: "title"),
            ),

        // const ViewTitle(
        //   title: "Dashboard",
        // ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                "Hi..👋, Thabang Mmusi",
                style: TextStyles.h1,
              ),
              SizedBox(height: Responsive.sidePadding(context)),
              search_bar(context),
              SizedBox(height: Responsive.sidePadding(context)),
              Padding(
                padding: EdgeInsets.only(left: Insets.xl, bottom: Insets.lg),
                child: Row(
                  children: [
                    Text(
                      "Recently Uploaded",
                      style: TextStyles.title1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: responsiveStatsBuilder(context)),

        const SliverToBoxAdapter(child: TableContainerWidget()),
        const SliverToBoxAdapter(child: TableContainerWidget()),
      ],
    );
  }

  ConstrainedBox search_bar(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 42, maxWidth: 540),
      child: SearchAnchor.bar(
          barBackgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.tertiaryContainer),
          barElevation: WidgetStateProperty.all(0),
          // barShape: WidgetStateProperty.all(OutlineInputBorder({})),
          //     //   builder:
          //     //     (BuildContext context, SearchController controller) {
          //     //   return SearchBar(
          //     //     controller: controller,
          //     //     padding: const WidgetStatePropertyAll<EdgeInsets>(
          //     //         EdgeInsets.symmetric(horizontal: 16.0)),
          //     //     onTap: () {
          //     //       controller.openView();
          //     //     },
          //     //     onChanged: (_) {
          //     //       controller.openView();
          //     //     },
          //     //     leading: const Icon(Icons.search),
          //     //     trailing: <Widget>[
          //     //       Tooltip(
          //     //         message: 'Change brightness mode',
          //     //         child: IconButton(
          //     //           // isSelected: isDark,
          //     //           onPressed: () {
          //     //             // setState(() {
          //     //             //   isDark = !isDark;
          //     //             // });
          //     //           },
          //     //           icon: const Icon(Icons.wb_sunny_outlined),
          //     //           selectedIcon:
          //     //               const Icon(Icons.brightness_2_outlined),
          //     //         ),
          //     //       )
          //     //     ],
          //     //   );
          //     // },
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
      // children: items.map((e) {
      //   return StatisticsWidgetNew(
      //       title: e.title!,
      //       bgColor: e.color!,
      //       value: NumberFormat.compact().format(e.counts),
      //       icon: e.icon!);
      // }).toList(),
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
                style: TextStyles.h3.copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                "Thabang Mmusi",
                style: TextStyles.h2,
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
      // viewBackgroundColor: theme.colorScheme.background,
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
                style: TextStyles.body2,
              ),
            )
            // const Icon(Ionicons.filter),
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
                  style: TextStyles.body2,
                ),
              )
              // const Icon(Ionicons.filter),
            ]),
          ),
        ),
      ),
    );
  }
}

class kSliverAppbar extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 100;
  final double maxTopBarHeight = 320;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? child;
  kSliverAppbar({
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
    Widget _leading = leading ?? const BackButton(color: Colors.white);
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
                color: Colors.green.withOpacity(0.3),
              )
            ]),
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8 * 1.5),
                width: MediaQuery.of(context).size.width * 0.5,
                // child: kSMSLogoDark
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amberAccent.withOpacity((shrinkFactor) * 1),
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
                        _leading,
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(title,
                            style: TextStyles.title1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(subtitle ?? "",
                            style: TextStyles.body2.copyWith(
                                color: Colors.white
                                    .withOpacity((shrinkFactor) * 1),
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
                    color: Colors.white.withOpacity(1.0 - shrinkFactor),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 10.0,
                        color: Colors.green
                            .withOpacity(0.23 - (0.23 * shrinkFactor)),
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
  double get maxExtent => 350;
  @override
  double get minExtent => 100;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
