import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:rich_ui/rich_ui.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_text.dart';
import '../../../styles.dart';
import '../../../widgets/my_button.dart';
import '../account_widgets.dart';
import '../../../features/uploads/presentation/upload_file_dialog.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selected, required this.onTap});
  final int selected;
  final Function(BuildContext context, int index) onTap;
  @override
  Widget build(BuildContext context) {
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails);
    return Padding(
      padding: EdgeInsets.all(Insets.med),
      child: RUiSideMenu(
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: Corners.medBorder),
        desktopViewWidth: 260,
        mainItemTheme: itemsTheme(context),
        subitemTheme: subItemsTheme(context),
        headerBuilder: (showIconOnly) => _buildLogo2(context, showIconOnly),
        footerBuilder: (showIconOnly) => Padding(
          padding: EdgeInsets.only(bottom: Insets.lg),
          child: AppButton(
            title: 'Sign out',
            iconToRight: true,
            icon: Ionicons.log_out_outline,
            outline: true,
            onTap: () {
              // Signing out the user
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ),
        builder: () => List.generate(4, (index) {
          return index == 2
              ? RUiSideButton(
                  iconData: bottomTaps[index].icon,
                  activeIcon: bottomTaps[index].activeIcon,
                  title: bottomTaps[index].label,
                  onPress: onTap,

                  ///fix the trailing
                  trailing: InkWell(
                    child: Icon(Ionicons.add_circle_outline),
                    onTap: () {},
                  ),
                )
              : index == 3
                  ? RUiSideButton(
                      useExpandableMenu: true,
                      iconData: bottomTaps[index].icon,
                      activeIcon: bottomTaps[index].activeIcon,
                      title: bottomTaps[index].label,
                      onPress: onTap,
                      items: course?.modules
                          .map(
                            (module) => RUiSideButton(
                              title: module,
                              onPress: (context, index) {
                                log("pressed module:$module");
                              },
                            ),
                          )
                          .toList())
                  : RUiSideButton(
                      iconData: bottomTaps[index].icon,
                      activeIcon: bottomTaps[index].activeIcon,
                      title: bottomTaps[index].label,
                      onPress: onTap,
                    );
        }),
        showIconOnly: false,
      ),
    );
  }

  RUiSideMenuItemTheme itemsTheme(BuildContext context) {
    return RUiSideMenuItemTheme(
        activeBackColor: Theme.of(context).primaryColor,
        foreColor: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        textStyle: TextStyles.title2,
        borderRadius: BorderRadius.circular(8));
  }

  RUiSideMenuItemTheme subItemsTheme(BuildContext context) {
    return RUiSideMenuItemTheme(
        activeBackColor: Theme.of(context).colorScheme.surface,
        foreColor: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        textStyle: TextStyles.title2,
        borderRadius: BorderRadius.circular(8));
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
