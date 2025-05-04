import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';

import '../../core.dart';

/// A customizable sidebar menu with support for sub-menu items, notification counters,
/// and a fixed profile section at the bottom.
class SidebarMenu extends StatefulWidget {
  /// The list of main menu items
  final List<SidebarMenuItem> menuItems;

  /// Profile data to display at the bottom
  final SidebarProfile profile;

  /// Background color of the sidebar
  final Color backgroundColor;

  /// Text and icon color for menu items
  final Color itemColor;

  /// Background color for selected menu item
  final Color selectedItemBackgroundColor;

  /// Text and icon color for selected menu item
  final Color selectedItemColor;

  /// Currently selected menu item ID
  final String? selectedItemId;

  /// Callback when a menu item is selected
  final Function(String itemId)? onItemSelected;

  /// Width of the sidebar
  final double width;

  /// Optional actions to display in the top-right corner
  final List<Widget>? topActions;

  const SidebarMenu({
    super.key,
    required this.menuItems,
    required this.profile,
    this.backgroundColor = const Color(0xFF151515),
    this.itemColor = Colors.white,
    this.selectedItemBackgroundColor = const Color(0xFF333333),
    this.selectedItemColor = Colors.white,
    this.selectedItemId,
    this.onItemSelected,
    this.width = 280,
    this.topActions,
  });

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  // Track expanded menu items
  final Set<String> _expandedItems = {};
  // Track selected item
  String? _selectedItemId;

  @override
  void initState() {
    super.initState();
    _selectedItemId = widget.selectedItemId;

    // Pre-expand items that contain the selected item
    if (_selectedItemId != null) {
      for (var item in widget.menuItems) {
        if (item.subItems != null) {
          for (var subItem in item.subItems!) {
            if (subItem.id == _selectedItemId) {
              _expandedItems.add(item.id);
              break;
            }
          }
        }
      }
    }
  }

  @override
  void didUpdateWidget(SidebarMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItemId != oldWidget.selectedItemId) {
      _selectedItemId = widget.selectedItemId;
    }
  }

  void _toggleExpanded(String itemId) {
    setState(() {
      if (_expandedItems.contains(itemId)) {
        _expandedItems.remove(itemId);
      } else {
        _expandedItems.add(itemId);
      }
    });
  }

  void _selectItem(String itemId) {
    setState(() {
      _selectedItemId = itemId;

      // Check if the selected item is a sub-item
      for (var item in widget.menuItems) {
        if (item.subItems != null) {
          for (var subItem in item.subItems!) {
            if (subItem.id == itemId) {
              // If a sub-item is selected, also mark the parent item as expanded
              _expandedItems.add(item.id);
              break;
            }
          }
        }
      }
    });

    if (widget.onItemSelected != null) {
      widget.onItemSelected!(itemId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.backgroundColor, borderRadius: Corners.medBorder),
      child: Column(
        children: [
          // Header section at top
          _buildHeader(),

          if (widget.topActions != null) ...widget.topActions!,
          // Fixed profile section at bottom

          // Scrollable menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildMenuItems(),
            ),
          ),
          _buildProfile(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withAlpha(40),
        borderRadius: const BorderRadius.only(
            topLeft: Corners.medRadius, topRight: Corners.medRadius),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const FullAppLogo(
                  showIconOnly: true,
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      // Light blue color
                      borderRadius: Corners.xlBorder,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 1,
                      )),
                  child: Text(
                    "Preview",
                    style: TextStyles.body4.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final List<Widget> menuWidgets = [];

    for (var item in widget.menuItems) {
      if (item.isSeparator) {
        menuWidgets.add(_buildSeparator());
      } else if (item.subItems != null && item.subItems!.isNotEmpty) {
        menuWidgets.add(_buildExpandableMenuItem(item));

        // Add sub-items if expanded
        if (_expandedItems.contains(item.id)) {
          for (var subItem in item.subItems!) {
            menuWidgets.add(_buildSubMenuItem(subItem));
          }
        }
      } else {
        menuWidgets.add(_buildMenuItem(item));
      }
    }

    return menuWidgets;
  }

  Widget _buildMenuItem(SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id;

    return _MenuItemBase(
      title: item.title,
      icon: item.icon,
      isSelected: isSelected,
      onTap: () => _selectItem(item.id),
      itemColor: widget.itemColor,
      selectedItemColor: widget.selectedItemColor,
      selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
      trailing: _buildTrailing(item, isSelected),
    );
  }

  Widget _buildExpandableMenuItem(SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id ||
        (item.subItems?.any((subItem) => subItem.id == _selectedItemId) ??
            false);
    final bool isExpanded = _expandedItems.contains(item.id);

    return _MenuItemBase(
      title: item.title,
      icon: item.icon,
      isSelected: isSelected,
      onTap: () => _toggleExpanded(item.id),
      itemColor: widget.itemColor,
      selectedItemColor: widget.selectedItemColor,
      selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.notificationCount != null && item.notificationCount! > 0)
            _buildNotificationCounter(item.notificationCount!),
          const SizedBox(width: 8),
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 16,
            color: isSelected ? widget.selectedItemColor : widget.itemColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id;

    return _MenuItemBase(
      title: item.title,
      isSelected: isSelected,
      onTap: () => _selectItem(item.id),
      itemColor: widget.itemColor,
      selectedItemColor: widget.selectedItemColor,
      selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
      margin: const EdgeInsets.only(left: 24, right: 12, top: 2, bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      trailing: item.notificationCount != null && item.notificationCount! > 0
          ? _buildNotificationCounter(item.notificationCount!)
          : null,
    );
  }

  Widget _buildNotificationCounter(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: const BoxConstraints(minWidth: 24),
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Divider(
        height: 1,
        color: widget.itemColor.withValues(alpha: 0.2),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.med)
          .copyWith(top: Insets.lg),
      padding: EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        border:
            Border.all(color: widget.itemColor.withValues(alpha: .1), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: widget.profile.avatarUrl != null
                ? NetworkImage(widget.profile.avatarUrl!)
                : null,
            child: widget.profile.avatarUrl == null
                ? Text(widget.profile.name[0],
                    style: const TextStyle(color: Colors.white))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.profile.name,
                  style: TextStyles.body2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.profile.courseName,
                  style: TextStyles.body4.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: widget.itemColor),
            onPressed: () {
              // Add your more menu logic here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(SidebarMenuItem item, bool isSelected) {
    if (item.notificationCount != null && item.notificationCount! > 0) {
      return _buildNotificationCounter(item.notificationCount!);
    }
    if (item.trailingIcon != null) {
      return Icon(
        item.trailingIcon,
        size: 18,
        color: isSelected
            ? widget.selectedItemColor
            : widget.itemColor.withValues(alpha: 0.7),
      );
    }
    return const SizedBox.shrink();
  }
}

/// Data model for a sidebar menu item
class SidebarMenuItem {
  /// Unique identifier for the menu item
  final String id;

  /// Display title
  final String title;

  /// Optional icon to display
  final IconData? icon;

  /// Optional trailing icon to display
  final IconData? trailingIcon;

  /// Optional notification counter
  final int? notificationCount;

  /// Optional sub-items
  final List<SidebarMenuItem>? subItems;

  /// Whether this item is just a separator
  final bool isSeparator;

  const SidebarMenuItem({
    required this.id,
    required this.title,
    this.icon,
    this.trailingIcon,
    this.notificationCount,
    this.subItems,
    this.isSeparator = false,
  });

  /// Create a separator item
  factory SidebarMenuItem.separator() {
    return const SidebarMenuItem(
      id: '',
      title: '',
      isSeparator: true,
    );
  }
}

/// Data model for sidebar profile information
class SidebarProfile {
  /// Display name for the profile
  final String name;
  final String courseName;

  /// Optional profile avatar URL
  final String? avatarUrl;

  const SidebarProfile({
    required this.name,
    required this.courseName,
    this.avatarUrl,
  });
}

class _MenuItemBase extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color itemColor;
  final Color selectedItemColor;
  final Color selectedItemBackgroundColor;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const _MenuItemBase({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.itemColor,
    required this.selectedItemColor,
    required this.selectedItemBackgroundColor,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: isSelected ? selectedItemBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 20,
                    color: isSelected ? selectedItemColor : itemColor,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? selectedItemColor : itemColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubMenuItemBase extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color itemColor;
  final Color selectedItemColor;
  final Color selectedItemBackgroundColor;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const _SubMenuItemBase({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.itemColor,
    required this.selectedItemColor,
    required this.selectedItemBackgroundColor,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: isSelected ? selectedItemBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: isSelected? Border(left: BorderSide(color: selectedItemColor, width: 4)) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? selectedItemColor : itemColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Then modify _buildMenuItem, _buildExpandableMenuItem, and _buildSubMenuItem to use _MenuItemBase:
