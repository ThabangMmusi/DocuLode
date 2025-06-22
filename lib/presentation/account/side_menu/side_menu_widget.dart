import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/widgets/buttons/buttons.dart';

import 'package:flutter/material.dart';

import 'package:doculode/core/components/app_logo.dart';

class SidebarProfile {
  final String name;
  final String courseName;
  final String? avatarUrl;
  const SidebarProfile(
      {required this.name, required this.courseName, this.avatarUrl});
}

class SidebarMenuItem {
  final String id;
  final String title;
  final IconData? icon;
  final IconData? trailingIcon;
  final int? notificationCount;
  final List<SidebarMenuItem>? subItems;
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

  factory SidebarMenuItem.separator() {
    return const SidebarMenuItem(id: '', title: '', isSeparator: true);
  }
}

class SidebarMenu extends StatefulWidget {
  final List<SidebarMenuItem> menuItems;
  final SidebarProfile profile;
  final Color? backgroundColor;
  final Color? itemColor;
  final Color? selectedItemBackgroundColor;
  final Color? selectedItemColor;
  final String? selectedItemId;
  final Function(String itemId)? onItemSelected;
  final double width;
  final List<Widget>? topActions;

  const SidebarMenu({
    super.key,
    required this.menuItems,
    required this.profile,
    this.backgroundColor,
    this.itemColor,
    this.selectedItemBackgroundColor,
    this.selectedItemColor,
    this.selectedItemId,
    this.onItemSelected,
    this.width = 280,
    this.topActions,
  });

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  final Set<String> _expandedItems = {};
  String? _selectedItemId;

  @override
  void initState() {
    super.initState();
    _selectedItemId = widget.selectedItemId;
    _preExpandSelected();
  }

  @override
  void didUpdateWidget(SidebarMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItemId != oldWidget.selectedItemId) {
      setState(() {
        _selectedItemId = widget.selectedItemId;
        _preExpandSelected();
      });
    }
  }

  void _preExpandSelected() {
    if (_selectedItemId != null) {
      for (var item in widget.menuItems) {
        if (item.subItems?.any((subItem) => subItem.id == _selectedItemId) ??
            false) {
          _expandedItems.add(item.id);
          break;
        }
      }
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

      for (var item in widget.menuItems) {
        if (item.subItems?.any((subItem) => subItem.id == itemId) ?? false) {
          _expandedItems.add(item.id);
          break;
        }
      }
    });
    widget.onItemSelected?.call(itemId);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? colorScheme.surface;

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: Corners.medBorder,
        boxShadow: Shadows.medium,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          if (widget.topActions != null && widget.topActions!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.sm),
              child: Column(children: widget.topActions!),
            ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: Insets.sm),
              children: _buildMenuItems(context),
            ),
          ),
          _buildProfile(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Corners.medRadius,
          topRight: Corners.medRadius,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Insets.med),
            child: Row(
              children: [
                const AppLogo(
                  variant: LogoVariant.horizontalWhite,
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Insets.sm, vertical: Insets.xs),
                  decoration: BoxDecoration(
                    borderRadius: Corners.xlBorder,
                    border: Border.all(
                      color: colorScheme.outline,
                      width: Strokes.thin,
                    ),
                  ),
                  child: Text(
                    "Preview",
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: Strokes.thin, color: colorScheme.outlineVariant),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final List<Widget> menuWidgets = [];
    for (var item in widget.menuItems) {
      if (item.isSeparator) {
        menuWidgets.add(_buildSeparator(context));
      } else if (item.subItems != null && item.subItems!.isNotEmpty) {
        menuWidgets.add(_buildExpandableMenuItem(context, item));
        if (_expandedItems.contains(item.id)) {
          for (var subItem in item.subItems!) {
            menuWidgets.add(_buildSubMenuItem(context, subItem));
          }
        }
      } else {
        menuWidgets.add(_buildMenuItem(context, item));
      }
    }
    return menuWidgets;
  }

  Widget _buildMenuItem(BuildContext context, SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id;
    return _MenuItemBase(
      title: item.title,
      icon: item.icon,
      isSelected: isSelected,
      onTap: () => _selectItem(item.id),
      itemColor: widget.itemColor,
      selectedItemColor: widget.selectedItemColor,
      selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
      trailing: _buildTrailing(context, item, isSelected),
    );
  }

  Widget _buildExpandableMenuItem(BuildContext context, SidebarMenuItem item) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = _selectedItemId == item.id ||
        (item.subItems?.any((subItem) => subItem.id == _selectedItemId) ??
            false);
    final bool isExpanded = _expandedItems.contains(item.id);
    final Color effectiveItemColor =
        widget.itemColor ?? theme.colorScheme.onSurfaceVariant;
    final Color effectiveSelectedItemColor =
        widget.selectedItemColor ?? theme.colorScheme.onPrimary;

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
            _buildNotificationCounter(context, item.notificationCount!),
          HSpace.sm,
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: IconSizes.med * 0.8,
            color: isSelected ? effectiveSelectedItemColor : effectiveItemColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id;
    return _MenuItemBase(
      title: item.title,
      isSelected: isSelected,
      onTap: () => _selectItem(item.id),
      itemColor: widget.itemColor,
      selectedItemColor: widget.selectedItemColor,
      selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
      margin: EdgeInsets.only(
          left: Insets.xl,
          right: Insets.med,
          top: Insets.xs,
          bottom: Insets.xs),
      padding:
          EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm + 2),
      isSubItem: true,
      trailing: item.notificationCount != null && item.notificationCount! > 0
          ? _buildNotificationCounter(context, item.notificationCount!)
          : null,
    );
  }

  Widget _buildNotificationCounter(BuildContext context, int count) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Insets.xs + 2, vertical: Insets.xs),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: Corners.xlBorder,
      ),
      constraints: BoxConstraints(minWidth: IconSizes.med),
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSeparator(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.med),
      child: Divider(
        height: Strokes.thin,
        color: widget.itemColor?.withOpacity(0.2) ??
            colorScheme.outlineVariant.withOpacity(0.5),
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final Color effectiveItemColor =
        widget.itemColor ?? colorScheme.onSurfaceVariant;

    return Container(
      margin: EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.med)
          .copyWith(top: Insets.lg),
      padding: EdgeInsets.all(Insets.med),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        border: Border.all(
            color: effectiveItemColor.withOpacity(0.1), width: Strokes.thin),
        borderRadius: Corners.smBorder,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: IconSizes.med * 0.8,
            backgroundColor: colorScheme.primaryContainer,
            backgroundImage: widget.profile.avatarUrl != null &&
                    widget.profile.avatarUrl!.isNotEmpty
                ? NetworkImage(widget.profile.avatarUrl!)
                : null,
            child: (widget.profile.avatarUrl == null ||
                    widget.profile.avatarUrl!.isEmpty)
                ? Text(
                    widget.profile.name.isNotEmpty
                        ? widget.profile.name[0].toUpperCase()
                        : '?',
                    style: textTheme.titleMedium
                        ?.copyWith(color: colorScheme.onPrimaryContainer))
                : null,
          ),
          HSpace.med,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.profile.name,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: effectiveItemColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.profile.courseName,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconBtn(
            Icons.logout_outlined,
            onPressed: () {
              print("Logout/More options tapped");
            },
            color: effectiveItemColor.withOpacity(0.8),
            tooltip: "Logout",
            isCompact: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(
      BuildContext context, SidebarMenuItem item, bool isSelected) {
    if (item.notificationCount != null && item.notificationCount! > 0) {
      return _buildNotificationCounter(context, item.notificationCount!);
    }
    if (item.trailingIcon != null) {
      final ThemeData theme = Theme.of(context);
      final Color effectiveItemColor =
          widget.itemColor ?? theme.colorScheme.onSurfaceVariant;
      final Color effectiveSelectedItemColor =
          widget.selectedItemColor ?? theme.colorScheme.onPrimary;
      return Icon(
        item.trailingIcon,
        size: IconSizes.med * 0.9,
        color: isSelected
            ? effectiveSelectedItemColor
            : effectiveItemColor.withOpacity(0.7),
      );
    }
    return const SizedBox.shrink();
  }
}

class _MenuItemBase extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? itemColor;
  final Color? selectedItemColor;
  final Color? selectedItemBackgroundColor;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isSubItem;

  const _MenuItemBase({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.itemColor,
    this.selectedItemColor,
    this.selectedItemBackgroundColor,
    this.icon,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    this.isSubItem = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    final Color effectiveItemColor = itemColor ?? colorScheme.onSurfaceVariant;
    final Color effectiveSelectedItemColor =
        selectedItemColor ?? colorScheme.onPrimary;
    final Color effectiveSelectedBgColor =
        selectedItemBackgroundColor ?? colorScheme.primary.withOpacity(0.9);
    final Color effectiveIconColor =
        isSelected ? effectiveSelectedItemColor : effectiveItemColor;
    final Color effectiveTextColor =
        isSelected ? effectiveSelectedItemColor : effectiveItemColor;

    final TextStyle itemTextStyle =
        (isSubItem ? textTheme.bodyMedium : textTheme.titleSmall) ??
            textTheme.bodyLarge!;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: isSelected ? effectiveSelectedBgColor : Colors.transparent,
        borderRadius: Corners.smBorder,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: Corners.smBorder,
          hoverColor: colorScheme.onSurface.withOpacity(0.04),
          splashColor: colorScheme.primary.withOpacity(0.08),
          highlightColor: colorScheme.onSurface.withOpacity(0.06),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: isSubItem ? IconSizes.med * 0.85 : IconSizes.med,
                    color: effectiveIconColor,
                  ),
                  HSpace.med,
                ],
                Expanded(
                  child: Text(
                    title,
                    style: itemTextStyle.copyWith(
                      color: effectiveTextColor,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
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
