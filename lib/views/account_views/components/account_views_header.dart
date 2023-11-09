// import 'package:flutter/material.dart';

// import '../../../constants/app_constants.dart';
// import '../../../utils/responsive.dart';
// import '../../../widgets/page_content_header.dart';

// class AccountsViewsHeader extends StatelessWidget {
//   const AccountsViewsHeader(
//       {super.key, required this.title, this.description, this.trailing});
//   final String title;
//   final String? description;
//   final Widget? trailing;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     left: Responsive.isMobile(context) ? kPaddingDefault : 0),
//                 child: PageContentHeader(
//                   header: title,
//                   subHeader: description,
//                 ),
//               ),
//             ),
//             if (trailing != null) trailing!
//           ],
//         ),
//         kVSpacingHalf,
//       ],
//     );
//   }
// }
