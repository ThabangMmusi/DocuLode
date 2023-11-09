import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../styles.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/labeled_text_input.dart';
import 'profile/profile_view.dart';
import 'home/home_view.dart';
import 'uploads/upload_view.dart';

Widget buildPages(int index) {
  List<Widget> widget = [
    const HomeView(),
    const UploadFileView(),
    const Center(
      child: Text("search"),
    ),
    const UserProfileView()
  ];

  return widget[index];
}

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
    NavigationItem(
      label: "Uploads",
      icon: Ionicons.file_tray_outline,
      activeIcon: Ionicons.file_tray,
    ),
    NavigationItem(
      label: "Search",
      icon: Ionicons.search_outline,
      activeIcon: Ionicons.search,
    ),
    NavigationItem(
      label: "Profile",
      icon: Ionicons.person_outline,
      activeIcon: Ionicons.person,
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
