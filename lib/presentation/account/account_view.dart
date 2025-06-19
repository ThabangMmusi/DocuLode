import 'package:doculode/features/shell/shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doculode/core/constants/app_colors.dart';
import 'package:doculode/config/styles.dart';
import 'package:doculode/core/constants/responsive.dart';
import 'account_widgets.dart';
import 'side_menu/side_menu_widget.dart';
import 'package:doculode/features/upload_progress/upload_progress.dart';

//for validating the authentications before the account
class MainAccountView extends StatelessWidget {
  MainAccountView({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.

  final StatefulNavigationShell navigationShell;
  final double padding = Insets.lg;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        body: BlocBuilder<UploadProgressBloc, UploadState>(
          // buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return Padding(
              padding: Responsive.isMobile(context)
                  ? EdgeInsets.zero
                  : EdgeInsets.all(padding),
              child: Stack(
                  // fit: StackFit.expand,
                  children: [
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
                              // if (connectionState ==
                              //     const ConnectionCubitState())
                              //   Container(
                              //     height: 30,
                              //     width: double.infinity,
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: Insets.lg),
                              //     decoration: BoxDecoration(
                              //       color: Theme.of(context)
                              //           .colorScheme
                              //           .primary
                              //           .withValues(alpha: .1),
                              //       border: Border(
                              //         bottom: BorderSide(
                              //             color: Theme.of(context)
                              //                 .colorScheme
                              //                 .primary),
                              //         top: BorderSide(
                              //             color: Theme.of(context)
                              //                 .colorScheme
                              //                 .primary),
                              //       ),
                              //     ),
                              //     child: Center(
                              //       child: Text(connectionState.connectionStatus
                              //           .toString()),
                              //     ),
                              //   ),

                              Expanded(
                                child: Responsive.isDesktop(context)
                                    ? Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            // border: Border(
                                            //   right: BorderSide(
                                            //     color: Colors.grey.shade100,
                                            //   ),
                                            // ),
                                            borderRadius: Corners.medBorder),
                                        child: navigationShell,
                                      )
                                    : Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: navigationShell),
                              ),
                            ],
                          ),
                        ),
                        // if (Responsive.isDesktop(context))
                        //   const UserProfileView()
                      ],
                    ),
                    if ((state.uploading && !state.close))
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: UploadProgressView(),
                      )
                  ]),
            );
          },
        ),
        bottomNavigationBar: !Responsive.isMobile(context)
            ? null
            : BottomNavigationBar(
                elevation: 0,
                backgroundColor: tWhiteColor,
                showSelectedLabels: true,
                selectedItemColor: tPrimaryColor,
                unselectedItemColor: tDarkColor.withValues(alpha: .5),
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

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
