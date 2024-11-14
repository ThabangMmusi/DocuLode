import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../styles.dart';
import '../../widgets/labeled_text_input.dart';

Widget searchBox() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: LabeledTextInput(
            filled: true,
            hintText: "Search",
            style: TextStyles.title1,
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
      icon: Ionicons.home_outline,
      activeIcon: Ionicons.home,
    ),
    // NavigationItem(
    //   label: "Search",
    //   icon: Ionicons.search_outline,
    //   activeIcon: Ionicons.search,
    // ),
    NavigationItem(
      label: "Uploads",
      icon: Ionicons.file_tray_outline,
      activeIcon: Ionicons.file_tray,
    ),
    NavigationItem(
      label: "Saved",
      icon: Ionicons.bookmark_outline,
      activeIcon: Ionicons.bookmark,
    ),
    NavigationItem(
      label: "Modules",
      icon: Ionicons.book_outline,
      activeIcon: Ionicons.book,
    )
  ];
}

class NavigationItem {
  String label;
  IconData? icon;
  IconData? activeIcon;
  NavigationItem({
    required this.label,
    this.icon,
    this.activeIcon,
  });
}
