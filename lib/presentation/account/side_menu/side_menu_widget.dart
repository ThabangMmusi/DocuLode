import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';

import '../../../core/common/auth/presentation/bloc/auth_bloc.dart';
import '../../../core/components/sidebar_menu/sidebar.dart';
import '../../../styles.dart';
import '../account_widgets.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onTap});
  final int selected;
  final Function(BuildContext context, int index) onTap;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final modules = state.user!.modules!;
    final user = state.user!;
    return SidebarMenu(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemBackgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        itemColor: Theme.of(context).colorScheme.onSurface,
        profile: SidebarProfile(
          name: "${user.surname} ${user.names}",
          courseName: state.user!.course!.name!,
          // avatarUrl: state.user!.,
        ),
        topActions: [
          Padding(
            padding: EdgeInsets.all(Insets.med).copyWith(bottom: Insets.xs),
            child: RawBtn(
              padding: EdgeInsets.all(Insets.sm),
              normalColors: BtnColors(
                bg: Theme.of(context).colorScheme.onSurface,
                fg: Theme.of(context).colorScheme.onPrimary,
              ),
              hoverColors: BtnColors(
                bg: Theme.of(context).colorScheme.primary,
                fg: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.search_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
        selectedItemId: selected.toString(),
        onItemSelected: (itemId) => onTap(context, int.parse(itemId)),
        menuItems: List.generate(
          bottomTaps.length - 1,
          (index) => bottomTaps[index].label == 'Divider'
              ? SidebarMenuItem.separator()
              : bottomTaps[index].label == 'Modules'
                  ? SidebarMenuItem(
                      id: bottomTaps[index].index.toString(),
                      icon: bottomTaps[index].icon,
                      title: bottomTaps[index].label,
                      subItems: modules
                          .map(
                            (module) => SidebarMenuItem(
                              id: module.id,
                              title: module.name!,
                            ),
                          )
                          .toList(),
                    )
                  : SidebarMenuItem(
                      id: bottomTaps[index].index.toString(),
                      icon: bottomTaps[index].icon,
                      title: bottomTaps[index].label,
                      trailingIcon: bottomTaps[index].trailingIcon,
                    ),
        ).toList());

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
}
