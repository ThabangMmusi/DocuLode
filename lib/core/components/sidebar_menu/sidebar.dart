import 'package:flutter/material.dart';

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
    });
    
    if (widget.onItemSelected != null) {
      widget.onItemSelected!(itemId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      color: widget.backgroundColor,
      child: Column(
        children: [
          // Profile section at top
          _buildProfileHeader(),
          
          // Scrollable menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildMenuItems(),
            ),
          ),
          
          // Fixed profile section at bottom
          _buildProfileFooter(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: widget.profile.avatarUrl != null 
                ? NetworkImage(widget.profile.avatarUrl!) 
                : null,
            child: widget.profile.avatarUrl == null 
                ? Text(widget.profile.name[0], style: const TextStyle(color: Colors.white))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.profile.name,
              style: TextStyle(
                color: widget.itemColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          if (widget.topActions != null) ...widget.topActions!,
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
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? widget.selectedItemBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectItem(item.id),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                if (item.icon != null)
                  Icon(
                    item.icon,
                    size: 20,
                    color: isSelected ? widget.selectedItemColor : widget.itemColor,
                  ),
                if (item.icon != null) const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? widget.selectedItemColor : widget.itemColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (item.trailingIcon != null)
                  Icon(
                    item.trailingIcon,
                    size: 16,
                    color: isSelected ? widget.selectedItemColor : widget.itemColor.withOpacity(0.7),
                  ),
                if (item.notificationCount != null && item.notificationCount! > 0)
                  _buildNotificationCounter(item.notificationCount!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableMenuItem(SidebarMenuItem item) {
    final bool isExpanded = _expandedItems.contains(item.id);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleExpanded(item.id),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                if (item.icon != null)
                  Icon(
                    item.icon,
                    size: 20,
                    color: widget.itemColor,
                  ),
                if (item.icon != null) const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: widget.itemColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (item.notificationCount != null && item.notificationCount! > 0)
                  _buildNotificationCounter(item.notificationCount!),
                const SizedBox(width: 8),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16,
                  color: widget.itemColor.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(SidebarMenuItem item) {
    final bool isSelected = _selectedItemId == item.id;
    
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 12, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: isSelected ? widget.selectedItemBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectItem(item.id),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? widget.selectedItemColor : widget.itemColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (item.notificationCount != null && item.notificationCount! > 0)
                  _buildNotificationCounter(item.notificationCount!),
              ],
            ),
          ),
        ),
      ),
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
        color: widget.itemColor.withOpacity(0.2),
      ),
    );
  }

  Widget _buildProfileFooter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: widget.profile.avatarUrl != null 
                ? NetworkImage(widget.profile.avatarUrl!) 
                : null,
            child: widget.profile.avatarUrl == null 
                ? Text(widget.profile.name[0], style: const TextStyle(color: Colors.white))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.profile.name,
              style: TextStyle(
                color: widget.itemColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
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
  
  /// Optional profile avatar URL
  final String? avatarUrl;
  
  const SidebarProfile({
    required this.name,
    this.avatarUrl,
  });
}