import 'package:doculode/config/index.dart';
import 'package:doculode/core/common/auth/presentation/bloc/auth_bloc.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/presentation/account/account_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

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
        ),
        topActions: [
          // Padding(
          //   padding: EdgeInsets.all(Insets.med).copyWith(bottom: Insets.xs),
          //   child: RawBtn(
          //     padding: EdgeInsets.all(Insets.sm),
          //     normalColors: BtnColors(
          //       bg: Theme.of(context).colorScheme.onSurface,
          //       fg: Theme.of(context).colorScheme.onPrimary,
          //     ),
          //     hoverColors: BtnColors(
          //       bg: Theme.of(context).colorScheme.primary,
          //       fg: Theme.of(context).colorScheme.onPrimary,
          //     ),
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Ionicons.search_outline, color: Colors.white),
          //         SizedBox(width: 8),
          //         Text(
          //           'Search',
          //           style: TextStyle(color: Colors.white, fontSize: 14),
          //         ),
          //       ],
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
        ],
        selectedItemId: selected.toString(),
        onItemSelected: (itemId) => onTap(context, int.parse(itemId)),
        menuItems: List.generate(
          bottomTaps.length,
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
  }
}
