import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rich_ui/rich_ui.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_text.dart';
import '../../../styles.dart';
import '../../../widgets/my_side_menu_button.dart';
import '../profile/sign_out_button.dart';
import '../account_widgets.dart';

part 'course_list_widget.dart';
part 'side_menu_category_widget.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onTap});
  final int selected;
  final Function(BuildContext context, int index) onTap;
  @override
  Widget build(BuildContext context) {
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails!);
    return RUiSideMenu(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      desktopViewWidth: 300,
      mainItemTheme: itemsTheme(context),
      subitemTheme: subItemsTheme(context),
      headerBuilder: (showIconOnly) => _buildLogo2(context, showIconOnly),
      footerBuilder: (showIconOnly) => const Padding(
        padding: EdgeInsets.only(bottom: kPaddingDefault),
        child: SignOutButton(),
      ),
      builder: () => List.generate(3, (index) {
        return index < 2
            ? RUiSideButton(
                iconData: bottomTaps[index].icon,
                activeIcon: bottomTaps[index].activeIcon,
                title: bottomTaps[index].label,
                onPress: onTap,
              )
            : RUiSideButton(
                useExpandableMenu: true,
                iconData: Ionicons.school_outline,
                activeIcon: Ionicons.school,
                items: List.generate(
                  course.modules!.length,
                  (index) => RUiSideButton(
                    title: course.modules![index],
                    onPress: (context, index) {},
                  ),
                ),
                title: "Courses",
              );
      }),
      showIconOnly: false,
    );
  }

  RUiSideMenuItemTheme itemsTheme(BuildContext context) {
    return RUiSideMenuItemTheme(
        activeBackColor: Theme.of(context).colorScheme.secondary,
        foreColor: Theme.of(context).colorScheme.onPrimary,
        textStyle: TextStyles.title2,
        borderRadius: BorderRadius.circular(8));
  }

  RUiSideMenuItemTheme subItemsTheme(BuildContext context) {
    return RUiSideMenuItemTheme(
        activeBackColor: Theme.of(context).colorScheme.surface,
        foreColor: Theme.of(context).colorScheme.onPrimary,
        textStyle: TextStyles.title2,
        borderRadius: BorderRadius.circular(8));
  }

  Widget _buildLogo2(BuildContext context, bool iconOnly) {
    return Padding(
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
    );
  }

  Widget _buildLogo(bool iconOnly) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 2.25),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kPaddingHalf),
            child: Image.asset(
              "assets/logos/logo.png",
              height: 32,
            ),
          ),
          if (!iconOnly)
            const Text(
              tAppName,
              style: TextStyle(
                  color: tPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          if (!iconOnly)
            const Text(
              tAppVersion,
              style: TextStyle(fontSize: 11),
            ),
        ],
      ),
    );
  }
}
