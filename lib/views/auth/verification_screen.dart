// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../constants/app_constants.dart';
// import '../../../widgets/my_button.dart';
// import '../../constants/app_enums.dart';
// import '../../constants/strings.dart';
// import '../../controllers/auth/auth_controller.dart';
// import '../../controllers/auth/auth_validator_controller.dart';
// import '../../widgets/loading_widget.dart';
// import '../../widgets/my_alert_dialog_box.dart';
// import '../../widgets/page_content_header.dart';
// import '../../widgets/password_widget.dart';

// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({Key? key}) : super(key: key);

//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   AuthController controller = AuthController.to;

//   final AuthValidatorController _loginController = AuthValidatorController.to;

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late bool _containsMode = false;
//   late bool _loading = false;
//   late bool _isPassword = false;
//   late bool _hasError = true;
//   late MessageModel messageModel;
//   late String myUrl, actionCode; //get complete url
//   @override
//   void initState() {
//     myUrl = Uri.base.toString(); //get complete url
//     messageModel = MessageModel("", "");
//     if (myUrl.contains("mode")) {
//       _containsMode = true;
//       if (myUrl.contains("verifyEmail")) {
//         _loading = true;
//         messageModel.message = "Verifying Email...";
//       } else if (myUrl.contains("resetPassword")) {
//         _loading = true;
//         messageModel.message = "Verifying Link...";
//       } else if (myUrl.contains("recoverEmail")) {
//         _loading = true;
//         messageModel.message = "Recovering Password...";
//       }
//       readData();
//     }
//     // _auth.signOut();
//     // String? para1 = Uri.base.queryParameters["para1"]; //get parameter with attribute "para1"
//     // String? para2 = Uri.base.queryParameters["para2"]; //get parameter with attribute "para2"
//     // var app = Firebase.app().au;
//     super.initState();
//   }

//   // TODO: This helpers should be implemented by the developer
//   String? getParameterByName(String name) {
//     var param =
//         Get.rootDelegate.currentConfiguration!.currentPage!.parameters?[name];
//     return param;
//     //get parameter with attribute "para1"
//     // String? para2 = Uri.base.queryParameters["para2"]; //get parameter with attribute "para2"
//     // name = name.replaceAll(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
//     // var regexS = "[\\?&]"+name+"=([^&#]*)";
//     // var regex = new RegExp( regexS );
//     // var results = regex.exec( window.location.href );
//     // if( results == null )
//     //   return "";}
//     // else
//     //   return decodeURIComponent(results[1].replace(/\+/g, " "));
//   }

// // [START auth_handle_mgmt_query_params]
//   void readData() {
//     // TODO: Implement getParameterByName()

//     // Get the action to complete.
//     var mode = getParameterByName('mode');
//     // Get the one-time code from the query parameter.
//     actionCode = getParameterByName('oobCode')!;
//     // (Optional) Get the continue URL from the query parameter if available.
//     // var continueUrl = getParameterByName('continueUrl');
//     // (Optional) Get the language code if available.
//     // var lang = getParameterByName('lang') || 'en';
//     // var lang = 'en';

//     // Handle the user management action.
//     switch (mode) {
//       case 'resetPassword':
//         // Display reset password handler and UI.
//         handleResetPassword();
//         break;
//       case 'recoverEmail':
//         // Display email recovery handler and UI.
//         // handleRecoverEmail(_auth, actionCode, lang);
//         break;
//       case 'verifyEmail':
//         // Display email verification handler and UI.
//         handleVerifyEmail();
//         break;
//       default:
//       // Error: invalid mode.
//     }
//     // [END auth_handle_mgmt_query_params]
//   }

// // [START auth_handle_reset_password]
//   void handleResetPassword() {
//     // Localize the UI to the selected language as determined by the lang
//     // parameter.

//     // Verify the password reset code is valid.
//     _auth.verifyPasswordResetCode(actionCode).then((email) {
//       setState(() {
//         _loading = false;
//         _isPassword = true;
//         messageModel.title = 'Enter New Password';
//         messageModel.message =
//             "You can now Sign in to complete the registration process.\n";
//         _hasError = false;
//         Get.log(messageModel.message);
//       });
//     }).onError((FirebaseAuthException error, stackTrace) {
//       setState(() {
//         messageModel = ErrorStrings.interpretErrorMessage(error.code);
//         _loading = false;
//         _isPassword = true;
//         // messageModel.title = "Failed!";
//       });
//       // Invalid or expired action code. Ask user to try to reset the password
//       // again.
//     });
//   }

//   void setNewPassword() {
//     showLoadingIndicator("Saving New Password");
//     // Save the new password.

//     _auth
//         .confirmPasswordReset(
//             code: actionCode, newPassword: _loginController.getPassword)
//         .then((resp) {
//       hideLoadingIndicator();
//       _loginController.clearAllPasswords();
//       Get.dialog(
//               const MyAlertDialog(
//                   type: AlertTypes.success,
//                   message: 'Successfully Changed Password'),
//               barrierDismissible: false)
//           .then((value) => Get.rootDelegate.toNamed(Routes.signIn));
//       // Password reset has been confirmed and new password updated.

//       // TODO: Display a link back to the app, or sign-in the user directly
//       // if the page belongs to the same domain as the app:
//       // auth.signInWithEmailAndPassword(accountEmail, newPassword);

//       // TODO: If a continue URL is available, display a button which on
//       // click redirects the user back to the app via continueUrl with
//       // additional state determined from that URL's parameters.
//     }).onError((FirebaseAuthException error, stackTrace) {
//       hideLoadingIndicator();
//       messageModel = ErrorStrings.interpretErrorMessage(error.code);
//       // NotificationController.to.title.value = messageModel.title;
//       // NotificationController.to.message.value = messageModel.message;

//       // NotificationController.to.showNotification();
//     });
//   }
// // [END auth_handle_reset_password]

// // [START auth_handle_recover_email]
//   // void handleRecoverEmail(FirebaseAuth auth, actionCode, lang) {
//   //   // Localize the UI to the selected language as determined by the lang
//   //   // parameter.
//   //   var restoredEmail = "";
//   //   // Confirm the action code is valid.
//   //   auth.checkActionCode(actionCode).then((info) {
//   //     // Get the restored email address.
//   //     restoredEmail = info['data']['email'];

//   //     // Revert to the old email.
//   //     return auth.applyActionCode(actionCode);
//   //   }).then(() {
//   //     // Account email reverted to restoredEmail

//   //     // TODO: Display a confirmation message to the user.

//   //     // You might also want to give the user the option to reset their password
//   //     // in case the account was compromised:
//   //     auth
//   //         .sendPasswordResetEmail(restoredEmail)
//   //         .then(() => {
//   //               // Password reset confirmation sent. Ask user to check their email.
//   //             })
//   //         .onError((error, stackTrace) {
//   //       // Error encountered while sending password reset code.
//   //     });
//   //   }).onError((error, stackTrace) {
//   //     // Invalid code.
//   //   });
//   // }

// // [END auth_handle_recover_email]

// // [START auth_handle_verify_email]
//   void handleVerifyEmail() async {
//     try {
//       await _auth.applyActionCode(actionCode).then((resp) {
//         setState(() {
//           _loading = false;
//           messageModel.title = 'Email Verified';
//           messageModel.message =
//               "You can now Sign in to complete the registration process.\n";
//           _hasError = false;
//           Get.log(messageModel.message);
//         });
//       });
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         messageModel = ErrorStrings.interpretErrorMessage(e.code);
//         _loading = false;
//         messageModel.title = "Verification failed!";
//         messageModel.message =
//             'This can happen if the link is malformed, expired, or has already been used.';
//         Get.log(messageModel.message);
//       });
//       // Get.dialog(
//       //         MyAlertDialog(
//       //             type: AlertTypes.error,
//       //             message: 'Unsuccessful Verified\n${e.message!}'),
//       //         barrierDismissible: false)
//       //     .then((value) => Get.rootDelegate.offNamed(Routes.login));
//       // Code is invalid or expired. Ask the user to verify their email address
//       // again.
//     }
//   }
// // [END auth_handle_verify_email]

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kBackgroundColor,
//         // appBar: myAppBarBuilder(context),
//         body: Center(
//             child: _loading
//                 ? LoadingWidget(text: messageModel.message)
//                 : Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // const AuthHeader(),
//                       Card(
//                         elevation: 6,
//                         child: _isPassword && !_hasError
//                             ? SizedBox(
//                                 width: 400,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(
//                                           kPaddingDefault * .75),
//                                       child: SizedBox(
//                                         height: 34,
//                                         child: PageContentHeader(
//                                           header: messageModel.title,
//                                           // subHeader: "Enter you email address",
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: const BoxDecoration(
//                                           border: Border(
//                                               bottom: BorderSide(
//                                                   color: kDividerColor),
//                                               top: BorderSide(
//                                                   color: kDividerColor))),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: kPaddingQuarter,
//                                           horizontal: kPaddingDefault),
//                                       child: const PasswordWidget(
//                                         isNew: true,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: kPaddingDefault,
//                                           bottom: kPaddingHalf),
//                                       child: Obx(
//                                         () => MyButton(
//                                           isEnabled: _loginController
//                                               .passwordIsValid.value,
//                                           onPressed: () {
//                                             setNewPassword();
//                                           },
//                                           text: "Change Password",
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ))
//                             : _containsMode
//                                 ? ConstrainedBox(
//                                     constraints:
//                                         const BoxConstraints(maxWidth: 460),
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.all(kPaddingDefault),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               if (_hasError)
//                                                 const Icon(
//                                                   Icons.warning_rounded,
//                                                   color: Colors.red,
//                                                   size: 46,
//                                                 ),
//                                               if (_hasError) kHSpacingDefault,
//                                               Text(
//                                                 _containsMode
//                                                     ? _hasError
//                                                         ? "Error!"
//                                                         : messageModel.title
//                                                     : 'Verify your email',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleLarge!
//                                                     .copyWith(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: _hasError
//                                                             ? Colors.red
//                                                             : Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                           kVSpacingHalf,
//                                           RichText(
//                                               text: TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: _containsMode
//                                                     ? messageModel.message
//                                                     : 'Verification email sent to ',
//                                                 // text: 'We have sent and email to ....'.
//                                                 style: const TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               if (!_containsMode)
//                                                 TextSpan(
//                                                   text:
//                                                       _loginController.getEmail,
//                                                   style: const TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: kAccentColor),
//                                                 ),
//                                               if (_hasError && !_isPassword)
//                                                 TextSpan(
//                                                   text: _containsMode
//                                                       ? ".\n\nYou need to log in and resend the verification email.\n\n"
//                                                       : '.\nYou need to verify your email to complete the registration process.',
//                                                   style: const TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               if (!_containsMode)
//                                                 const TextSpan(
//                                                   text:
//                                                       "\n\nDid not received the email? ",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               if (!_containsMode)
//                                                 TextSpan(
//                                                   text: 'Resend it.\n\n',
//                                                   style: const TextStyle(
//                                                       color: Colors.blue),
//                                                   recognizer:
//                                                       TapGestureRecognizer()
//                                                         ..onTap = () async {
//                                                           FirebaseAuth.instance
//                                                               .currentUser!
//                                                               .sendEmailVerification();
//                                                         },
//                                                 ),
//                                             ],
//                                           )),
//                                           if (_isPassword) kVSpacingDefault,
//                                           if (!_hasError)
//                                             MyButton(
//                                                 text: _isPassword
//                                                     ? "Resend Link"
//                                                     : "Sign In",
//                                                 onPressed: () {
//                                                   if (_isPassword) {
//                                                     Get.rootDelegate
//                                                         .offAndToNamed(Routes
//                                                             .forgotPassword);
//                                                   } else {
//                                                     if (controller.firebaseUser
//                                                             .value !=
//                                                         null) {
//                                                       controller.signOut();
//                                                     }
//                                                     Get.rootDelegate
//                                                         .offAndToNamed(
//                                                             Routes.signIn);
//                                                   }
//                                                 })
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : ConstrainedBox(
//                                     constraints:
//                                         const BoxConstraints(maxWidth: 460),
//                                     child: Padding(
//                                       padding:
//                                           const EdgeInsets.all(kPaddingDefault),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             'Verify your email',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge!
//                                                 .copyWith(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                           ),
//                                           kVSpacingHalf,
//                                           RichText(
//                                               text: TextSpan(
//                                             children: [
//                                               const TextSpan(
//                                                 text:
//                                                     'We have sent you an email to ',
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               TextSpan(
//                                                 text: controller
//                                                     .firebaseUser.value!.email,
//                                                 style: const TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: kAccentColor),
//                                               ),
//                                               const TextSpan(
//                                                 text:
//                                                     '.\nYou need to verify your email to complete the registration process.',
//                                                 style: TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                               const TextSpan(
//                                                 text:
//                                                     "\n\nDid not received the email? ",
//                                                 style: TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                               TextSpan(
//                                                 text: 'Resend Link.',
//                                                 style: const TextStyle(
//                                                     color: Colors.blue,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 recognizer:
//                                                     TapGestureRecognizer()
//                                                       ..onTap = () {
//                                                         controller
//                                                             .firebaseUser.value!
//                                                             .sendEmailVerification();
//                                                       },
//                                               ),
//                                             ],
//                                           )),
//                                           kVSpacingDefault,
//                                           MyButton(
//                                               text: !_containsMode
//                                                   ? "Just Verified"
//                                                   : "Sign in",
//                                               onPressed: () {
//                                                 if (!_containsMode) {
//                                                   controller.signOut();
//                                                 } else {
//                                                   Get.rootDelegate
//                                                       .offNamed(Routes.signIn);
//                                                 }
//                                               })
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                       ),
//                     ],
//                   )));
//   }
// }
