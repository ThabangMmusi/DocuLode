import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../_utils/logger.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/responsive.dart';
import '../../styles.dart';
import '../../widgets/category_button.dart';
import '../../widgets/decorated_container.dart';
import '../app_title_bar/app_title_bar.dart';
import 'account_widgets.dart';
import 'side_menu/side_menu_widget.dart';

//for validating the authentications before the acu
class MainAccountView extends StatelessWidget {
  const MainAccountView({
    super.key,
    required this.navigationShell,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, authState) {
        return authState.status == AuthStatus.authenticating ||
                authState.status == AuthStatus.unknown
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              )
            : SafeArea(
                child: _AccountScaffold(navigationShell: navigationShell),
              );
      },
    );
  }
}

class _AccountScaffold extends StatelessWidget {
  const _AccountScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      //     Responsive.isDesktop(context) ? MyAppBar(context) : null,
      // appBar: MyAppBar(context),
      // backgroundColor: tPrimaryColor.withOpacity(0.05),
      // backgroundColor: tWhiteColor,
      // appBar: MyAppBar(context),
      body: Row(
        children: [
          if (!Responsive.isMobile(context))
            SideMenu(
              selected: navigationShell.currentIndex,
              onTap: _onTap,
            ),
          Expanded(
            child: Column(
              children: [
                // _buildAppBar(state),

                // if (state.user.givenNames != null)
                //   Row(
                //     mainAxisAlignment:
                //         MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Hello, ${state.user.getSingleName}",
                //         style: const TextStyle(
                //             color: tDarkColor,
                //             fontSize: 26),
                //       ),
                //     ],
                //   ),
                // UserCourseWidget(
                //   user: state.user,
                // ),
                _buildAppBar(context),
                // if (navigationShell.currentIndex == 0)

                if (!Responsive.isDesktop(context)) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: kPaddingDefault),
                    child: searchBox(),
                  )
                ],

                Expanded(child: navigationShell),
              ],
            ),
          ),
          // if (Responsive.isDesktop(context))
          //   const UserProfileView()
        ],
      ),
      bottomNavigationBar: !Responsive.isMobile(context)
          ? null
          : BottomNavigationBar(
              elevation: 0,
              backgroundColor: tWhiteColor,
              showSelectedLabels: true,
              selectedItemColor: tPrimaryColor,
              unselectedItemColor: tDarkColor.withOpacity(.5),
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
    );
  }

  // Widget _buildAppBar(AuthState state) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             bottomTaps[navigationShell.currentIndex].label,
  //             style: const TextStyle(color: tDarkColor, fontSize: 26),
  //           ),
  //           Text(
  //             "Your startup point.",
  //             style: TextStyle(color: tDarkColor.withAlpha(100), fontSize: 12),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 state.user.getFullNames,
  //                 style: const TextStyle(
  //                     color: tDarkColor, fontWeight: FontWeight.bold),
  //               ),
  //               UserCourseWidget(
  //                 user: state.user,
  //               )
  //             ],
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: kPaddingHalf),
  //             child: Icon(
  //               Ionicons.person_circle_outline,
  //               size: 32,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildAppBar(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Column(
      children: [
        const AppTitleBar(),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
          child: DecoratedContainer(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.all(Insets.lg),
            borderRadius: Corners.lg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                // Text(
                //   bottomTaps[navigationShell.currentIndex].label,
                //   style: TextStyles.h2,
                // ),
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: searchBox()),
                //     Text(
                //       "Your startup point.",
                //       style: TextStyle(
                //           color: tDarkColor.withAlpha(100), fontSize: 12),
                //     ),
                //   ],
                // ),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          user!.getFullNames,
                          style: const TextStyle(
                              color: tDarkColor, fontWeight: FontWeight.bold),
                        ),
                        const UserCourseWidget()
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPaddingHalf),
                      child: Icon(
                        Ionicons.person_circle_outline,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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

class UserCourseWidget extends StatelessWidget {
  const UserCourseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails!);
    return Row(
      children: [
        Text(
          course.name,
          style: const TextStyle(color: tPrimaryColor, fontSize: 11),
        ),
        Text(
          "(${course.code})",
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}

class CourseCategory extends StatelessWidget {
  const CourseCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails!);
    return Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.amber,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: course.modules!.length,
            separatorBuilder: (context, index) => kHSpacingHalf,
            itemBuilder: (listContext, index) => CategoryButton(
                  index: index,
                  onPressed: () => log(course.modules![index]),
                  title: course.modules![index],
                )));
  }
}
