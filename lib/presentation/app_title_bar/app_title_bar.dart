import 'package:flutter/material.dart';

import '../../_utils/device_info.dart';
import '../../_utils/native_window_utils/window_utils.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Optionally wrap the content in a Native title bar. This may be a no-op depending on platform.
    return IoUtils.instance.wrapNativeTitleBarIfRequired(ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 30),
      child: _AdaptiveTitleBarContent(),
    ));
  }
}

class _AdaptiveTitleBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine whether to show back button.
    // bool isGuestUser = context.select((AppModel m) => m.isGuestUser);
    // bool canGoBack = context.select((BooksModel m) => m.currentBook != null);
    // bool showBackBtn = isGuestUser == false && canGoBack;
    // double appWidth = context.widthPx;
    // Mac title bar has a different layout as it's window btns are left aligned
    // bool isMac = DeviceOS.isMacOS;
    // bool isMobile = DeviceOS.isMobile;
    // bool showTouchToggle = DeviceScreen.isPhone(context) == false;
    return Stack(children: [
      // Centered TitleText
      // if (appWidth > 400) Center(child: _TitleText()),
      // Btns
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     if (isMac || isMobile) ...[
      //       if (isMac) const HSpace(80), // Reserve some space for the native btns
      //       if (showBackBtn) _BackBtn(),
      //       const Spacer(),
      //       if (showTouchToggle) TouchModeToggleBtn(invertPopupAlign: isMac),
      //       HSpace.sm,
      //       RoundedProfileBtn(
      //         key: _profileBtnKey,
      //         invertRow: true,
      //         useBottomSheet: isMobile,
      //       ),
      //       HSpace.sm,
      //     ] else ...[
      //       HSpace.sm,
      //       // Linux and Windows are left aligned and simple
      //       RoundedProfileBtn(
      //         key: _profileBtnKey,
      //         useBottomSheet: isMobile,
      //       ),
      //       HSpace.sm,
      //       if (showTouchToggle) TouchModeToggleBtn(invertPopupAlign: isMac),
      //       HSpace.sm,
      //       if (showBackBtn) _BackBtn(),
      //     ]
      //   ],
      // ),
    ]);
  }

  // static const Key _profileBtnKey = Key('rounded_profile_button');
}

// class _TitleText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const IgnorePointer(
//       child: Center(child: AppLogoText(constraints: BoxConstraints(maxHeight: 16))),
//     );
//   }
// }

// class _BackBtn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     AppTheme theme = Provider.of(context);
//     return FadeInDown(
//         child: SimpleBtn(
//       onPressed: () => handleBackPressed(context),
//       child: SizedBox(
//         height: double.infinity,
//         child: Row(
//           children: [
//             const Icon(Icons.chevron_left),
//             Text("Back", style: TextStyles.body2.copyWith(color: theme.greyStrong)),
//             HSpace.med
//           ],
//         ),
//       ),
//     ));
//   }

//   void handleBackPressed(BuildContext context) {
//     InputUtils.unFocus();
//     context.read<AppModel>().popNav();
//   }
// }
