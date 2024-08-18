import 'package:flutter/material.dart';

class ComplexMenuItem {
  //complex drawer menu
  final IconData icon;
  final Function()? onPress;
  final String title;
  final List<ComplexMenuItem> submenus;

  ComplexMenuItem(this.icon, this.title, this.submenus, {this.onPress});
}

class SideMenuItemModel {
  final bool canBeSelected;
  final String title;
  final Function()? onPressed;
  final IconData iconData;
  final List<Widget>? items;
  final Function(int)? onItemPress;

  SideMenuItemModel(
      {required this.title,
      required this.iconData,
      this.onPressed,
      this.items,
      this.onItemPress,
      this.canBeSelected = true});
}
