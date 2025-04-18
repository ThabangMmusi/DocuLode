import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
// import 'package:rich_ui/rich_ui.dart';

import '../../../core/bloc/auth/auth_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_text.dart';
import '../../../core/components/sidebar_menu/sidebar.dart';
import '../../../styles.dart';
import '../account_widgets.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onTap});
  final int selected;
  final Function(BuildContext context, int index) onTap;
  @override
  Widget build(BuildContext context) {
    String _selectedItemId = 'dashboard';
    final state = context.watch<AuthBloc>().state;
    final modules = state.user!.modules!;
    return SidebarMenu(
      profile: const SidebarProfile(
        name: 'Frankie Sullivan',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      topActions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
          onPressed: () {},
        ),
      ],
      selectedItemId: _selectedItemId,
      onItemSelected: (itemId) {
        // setState(() {
        _selectedItemId = itemId;
        // });
        // Handle navigation or other actions
      },
      menuItems: [
        const SidebarMenuItem(
          id: 'dashboard',
          title: 'Dashboard',
          icon: Icons.dashboard_outlined,
        ),
        const SidebarMenuItem(
          id: 'view_site',
          title: 'View site',
          icon: Icons.desktop_windows_outlined,
          trailingIcon: Icons.open_in_new,
        ),
        const SidebarMenuItem(
          id: 'marketplace',
          title: 'Marketplace',
          icon: Icons.shopping_cart_outlined,
        ),
        SidebarMenuItem.separator(),
        const SidebarMenuItem(
          id: 'posts',
          title: 'Posts',
          icon: Icons.edit_note,
          trailingIcon: Icons.add,
          subItems: [
            SidebarMenuItem(
              id: 'drafts',
              title: 'Drafts',
              notificationCount: 10,
            ),
            SidebarMenuItem(
              id: 'scheduled',
              title: 'Scheduled',
              notificationCount: 2,
            ),
            SidebarMenuItem(
              id: 'published',
              title: 'Published',
              notificationCount: 28,
            ),
          ],
        ),
        const SidebarMenuItem(
          id: 'pages',
          title: 'Pages',
          icon: Icons.web_stories_outlined,
          trailingIcon: Icons.add,
        ),
        const SidebarMenuItem(
          id: 'performance',
          title: 'Performance',
          icon: Icons.pie_chart_outline,
        ),
      ],
    );

    // return RUiSideMenu(
    //   padding: EdgeInsets.symmetric(horizontal: Insets.lg),
    //   decoration: BoxDecoration(
    //       color: Theme.of(context).colorScheme.surface,
    //       borderRadius: Corners.medBorder),
    //   desktopViewWidth: 260,
    //   mainItemTheme: itemsTheme(context),
    //   subitemTheme: subItemsTheme(context),
    //   headerBuilder: (showIconOnly) => _buildLogo2(context, showIconOnly),
    //   footerBuilder: (showIconOnly) => Padding(
    //     padding: EdgeInsets.only(bottom: Insets.lg),
    //     child: SecondaryBtn(
    //       label: 'Sign out',
    //       leadingIcon: true,
    //       icon: Ionicons.log_out_outline,
    //       isCompact: true,
    //       onPressed: () {
    //         // Signing out the user
    //         context.read<AuthBloc>().add(AuthLogoutRequested());
    //       },
    //     ),
    //   ),
    //   builder: () => List.generate(4, (index) {
    //     return index == 1
    //         ? RUiSideButton(
    //             iconData: bottomTaps[index].icon,
    //             activeIcon: bottomTaps[index].activeIcon,
    //             title: bottomTaps[index].label,
    //             onPress: onTap,

    //             ///fix the trailing
    //             trailing: InkWell(
    //               child: const Icon(Ionicons.add_circle_outline),
    //               onTap: () {},
    //             ),
    //           )
    //         : index == 3
    //             ? RUiSideButton(
    //                 useExpandableMenu: true,
    //                 iconData: bottomTaps[index].icon,
    //                 activeIcon: bottomTaps[index].activeIcon,
    //                 title: bottomTaps[index].label,
    //                 onPress: onTap,
    //                 items: modules
    //                     .map(
    //                       (module) => RUiSideButton(
    //                         title: module.name!,
    //                         onPress: (context, index) {
    //                           log("pressed module:$module");
    //                         },
    //                       ),
    //                     )
    //                     .toList())
    //             : RUiSideButton(
    //                 iconData: bottomTaps[index].icon,
    //                 activeIcon: bottomTaps[index].activeIcon,
    //                 title: bottomTaps[index].label,
    //                 onPress: onTap,
    //               );
    //   }),
    //   showIconOnly: false,
    // );
  }

  // RUiSideMenuItemTheme itemsTheme(BuildContext context) {
  //   return RUiSideMenuItemTheme(
  //       activeBackColor: Theme.of(context).primaryColor,
  //       foreColor: Theme.of(context).colorScheme.onSurface.withAlpha(150),
  //       textStyle: TextStyles.title2,
  //       borderRadius: BorderRadius.circular(8));
  // }

  // RUiSideMenuItemTheme subItemsTheme(BuildContext context) {
  //   return RUiSideMenuItemTheme(
  //       activeBackColor: Theme.of(context).colorScheme.surface,
  //       foreColor: Theme.of(context).colorScheme.onSurface.withAlpha(150),
  //       textStyle: TextStyles.title2,
  //       borderRadius: BorderRadius.circular(8));
  // }

  Widget _buildQuickAction(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo2(BuildContext context, bool iconOnly) {
    return Stack(
      children: [
        MoveWindow(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 2.25),
          child: Column(
            children: [
              if (!iconOnly) ...[
                Text(
                  tAppName,
                  style: TextStyles.h2.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  tAppVersion,
                  style: TextStyles.body2.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w300),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
