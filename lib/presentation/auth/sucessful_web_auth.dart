import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/commands/app/authenticate_desktop_command.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../styles.dart';
import '../../widgets/my_button.dart';

class SuccessfulWebAuth extends StatelessWidget {
  const SuccessfulWebAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(kPaddingDefault * 2),
              decoration: BoxDecoration(
                  color: tWhiteColor, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const AuthHeaderWidget(),
                  Text(
                    "You're logged in as",
                    style: TextStyles.h2,
                  ),
                  kVSpacingDefault,
                  const Icon(
                    Ionicons.person_circle_outline,
                    size: 16 * 4,
                  ),
                  // kVSpacingDefault,
                  // Text(
                  //   "You're successfully logged in as",
                  //   style: TextStyles.title1,
                  // ),
                  kVSpacingDefault,
                  Text(
                    "Thabang Mmusi",
                    style: TextStyles.h3,
                  ),
                  kVSpacingDefault,
                  AppButton(
                    loading: false,
                    title: "Continue to the app",
                    iconToRight: true,
                    icon: Ionicons.open_outline,
                    onTap: () => AuthenticateDesktopCommand().run(),
                  ),

                  kVSpacingDefault,
                  RichText(
                    text: TextSpan(
                        text: 'Not you? ',
                        style: TextStyles.body2.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                        children: [
                          TextSpan(
                            text: "Log in to another account",
                            style: TextStyles.body2.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          )
                        ]),
                  )
                ],
              ))),
    );
  }
}
