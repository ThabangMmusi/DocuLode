import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
  ];
}