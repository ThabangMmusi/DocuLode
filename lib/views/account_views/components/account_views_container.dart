// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_soxiety_web/screens/account_views/components/account_views_header.dart';

// import '../../../constants/app_constants.dart';
// import '../../../utils/responsive.dart';

// class AccountViewsSingleView extends StatelessWidget {
//   const AccountViewsSingleView(
//       {super.key,
//       required this.headerTitle,
//       required this.headerDescription,
//       this.headerTrailing,
//       required this.content});

//   final String headerTitle, headerDescription;
//   final Widget? headerTrailing;
//   final Widget content;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AccountsViewsHeader(
//             title: headerTitle,
//             description: headerDescription,
//             trailing: headerTrailing),
//         Container(
//           clipBehavior: Clip.antiAlias,
//           constraints: BoxConstraints(
//             maxHeight: Get.height - (Responsive.isMobile(context) ? 120 : 164),
//           ),
//           // padding: const EdgeInsets.fromLTRB(
//           //     kPaddingDefault, kPaddingHalf, kPaddingDefault, 0),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(kPaddingHalf)),
//           child: Center(heightFactor: 1, child: content),
//         ),
//       ],
//     );
//   }
// }
