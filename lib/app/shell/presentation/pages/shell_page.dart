import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/app/shell/presentation/widgets/side_menu/side_menu_widget.dart';
import 'package:doculode/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:doculode/features/upload_progress/presentation/views/upload_progress_view.dart';
import 'package:doculode/presentation/account/account_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShellPage extends StatelessWidget {
  ShellPage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;
  final double padding = Insets.lg;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        body: 
        // BlocBuilder<UploadProgressBloc, UploadState>(
        //   builder: (context, state) {
        //     return Padding(
        //       padding: Responsive.isMobile(context)
        //           ? EdgeInsets.zero
        //           : EdgeInsets.all(padding),
        //       child: Stack(children: [
                
                Row(
                  children: [
                    if (!Responsive.isMobile(context)) ...[
                      SideMenu(
                        selected: navigationShell.currentIndex,
                        onTap: _onTap,
                      ),
                      HSpace(padding)
                    ],
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Responsive.isDesktop(context)
                                ? Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: Corners.medBorder),
                                    child: navigationShell,
                                  )
                                : Container(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: navigationShell),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          //       if ((state.uploading && !state.close))
          //         const Align(
          //           alignment: Alignment.bottomRight,
          //           child: UploadProgressView(),
          //         )
          //     ]),
            // );
          // },
        // ),
        bottomNavigationBar: !Responsive.isMobile(context)
            ? null
            : BottomNavigationBar(
                elevation: 0,
                backgroundColor: tWhiteColor,
                showSelectedLabels: true,
                selectedItemColor: tPrimaryColor,
                unselectedItemColor: tDarkColor.withAlpha(128),
                items: bottomTaps
                    .map(
                      (e) => BottomNavigationBarItem(
                        backgroundColor: tWhiteColor,
                        label: e.label,
                        icon: Icon(e.icon),
                        activeIcon: Icon(e.activeIcon),
                      ),
                    )
                    .toList(),
                currentIndex: navigationShell.currentIndex,
                onTap: (int index) => _onTap(context, index),
              ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
