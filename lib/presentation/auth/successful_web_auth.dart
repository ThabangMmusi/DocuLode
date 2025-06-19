// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:doculode/_utils/logger.dart';
// import 'package:doculode/commands/app/authenticate_desktop_command.dart';

// import '../../constants/app_colors.dart';
// import '../../constants/app_constants.dart';
// import '../../styles.dart';

// class SuccessfulWebAuth extends StatelessWidget {
//   const SuccessfulWebAuth({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Container(
//               padding: const EdgeInsets.all(kPaddingDefault * 2),
//               decoration: BoxDecoration(
//                   color: tWhiteColor, borderRadius: BorderRadius.circular(12)),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // const AuthHeaderWidget(),
//                   Text(
//                     "You're logged in as",
//                     style: TextStyles.headlineMedium,
//                   ),
//                   kVSpacingDefault,
//                   const Icon(
//                     Ionicons.person_circle_outline,
//                     size: 16 * 4,
//                   ),
//                   // kVSpacingDefault,
//                   // Text(
//                   //   "You're successfully logged in as",
//                   //   style: TextStyles.titleLarge,
//                   // ),
//                   kVSpacingDefault,
//                   Text(
//                     "Thabang Mmusi",
//                     style: TextStyles.headlineSmall,
//                   ),
//                   kVSpacingDefault,
//                   PrimaryBtn(
//                     label: "Continue to the app",
//                     leadingIcon: false,
//                     icon: Ionicons.open_outline,
//                     onPressed: () => AuthenticateDesktopCommand().run(),
//                   ),

//                   kVSpacingDefault,
//                   RichText(
//                     text: TextSpan(
//                         text: 'Not you? ',
//                         style: TextStyles.bodyMedium.copyWith(
//                             color: Theme.of(context).colorScheme.onSurface),
//                         children: [
//                           TextSpan(
//                             text: "Log in to another account",
//                             style: TextStyles.bodyMedium.copyWith(
//                                 color: Theme.of(context).colorScheme.primary),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () => log('Tap Here onTap'),
//                           )
//                         ]),
//                   )
//                 ],
//               ))),
//     );
//   }
// }
