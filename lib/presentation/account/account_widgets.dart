import 'package:doculode/app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:doculode/app/config/styles.dart';

import 'package:doculode/core/widgets/styled_text_input.dart';

Widget searchBox() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: StyledTextInput(
            // : true,
            hintText: "Search",
            style: TextStyles.titleLarge,
            prefixIcon: const Icon(
              Ionicons.search,
              // color: Colors.red,
            ),
            onChanged: (value) {}),
      ),
      // Padding(
      //   padding:
      //       const EdgeInsets.only(bottom: kPaddingHalf, left: kPaddingHalf),
      //   child: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       width: 46,
      //       height: 46,
      //       decoration: BoxDecoration(
      //         color: tPrimaryColor,
      //         borderRadius: BorderRadius.circular(kPaddingHalf),
      //       ),
      //       child: const Icon(
      //         Ionicons.filter,
      //         color: tWhiteColor,
      //       ),
      //     ),
      //   ),
      // )
    ],
  );
}

List<NavigationItem> get bottomTaps {
  return [
    NavigationItem(
      label: "Dashboard",
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      index: 0,
    ),
    NavigationItem(
      label: "Uploads",
      icon: Icons.edit_note,
      activeIcon: Ionicons.file_tray,
      trailingIcon: Icons.add,
      index: 1,
    ),
    NavigationItem(
      label: "Saved",
      icon: Icons.bookmark_outline,
      activeIcon: Ionicons.bookmark,
      index: 2,
    ),
    NavigationItem(
      label: "Modules",
      icon: Icons.web_stories_outlined,
      activeIcon: Ionicons.book,
      index: 3,
    ),
    NavigationItem(
      label: "Divider",
    ),
    NavigationItem(
      label: "Settings",
      icon: Icons.settings,
      activeIcon: Ionicons.book,
      index: 4,
    ),
    NavigationItem(
      label: "Search",
      icon: Ionicons.search,
      activeIcon: Ionicons.search,
      index: 5,
    ),
  ];
}

class NavigationItem {
  String label;
  IconData? icon;
  IconData? activeIcon;
  IconData? trailingIcon;
  int? index;
  NavigationItem({
    required this.label,
    this.icon,
    this.activeIcon,
    this.trailingIcon,
    this.index,
  });
}
