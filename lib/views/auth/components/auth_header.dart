// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../constants/app_constants.dart';
// import '../../../controllers/auth/auth_validator_controller.dart';

// class AuthHeader extends GetView<AuthValidatorController> {
//   const AuthHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               SvgLogosPath.logoDark,
//               width: 60,
//             ),
//             kHSpacingDefault,
//             SvgPicture.asset(
//               SvgLogosPath.logoDarkName,
//               height: 30,
//             )
//           ],
//         ),
//         kVSpacingDefault,
//         Obx(() => controller.hasError.isTrue
//             ? Container(
//                 constraints: const BoxConstraints(maxWidth: 400),
//                 padding: const EdgeInsets.all(kPaddingDefault / 2),
//                 margin: const EdgeInsets.only(bottom: kPaddingDefault),
//                 decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     border: Border.all(color: Colors.red.shade300),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.error_outline_outlined),
//                     const SizedBox(width: kPaddingDefault / 2),
//                     Expanded(
//                       child: Text(
//                         controller.errorMessage(),
//                         softWrap: true,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             : Container()),
//       ],
//     );
//   }
// }
