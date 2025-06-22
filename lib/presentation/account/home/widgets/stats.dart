import 'package:doculode/app/config/index.dart';













import 'package:flutter/material.dart';


class StatisticsWidgetNew extends StatelessWidget {
  const StatisticsWidgetNew({
    super.key,
    required this.title,
    required this.bgColor,
    required this.value,
    required this.icon,
  });
  final String title;
  final String value;
  final Color bgColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(Insets.med),
        // boxShadow: const [
        //   BoxShadow(
        //       color: Color.fromARGB(26, 0, 0, 0),
        //       blurRadius: 4,
        //       spreadRadius: 0)
        // ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Insets.sm),
                    decoration: BoxDecoration(
                      color: bgColor.withValues(alpha: .35),
                      borderRadius: BorderRadius.circular(Insets.med),
                    ),
                    child: Icon(
                      icon,
                      color: bgColor,
                      size: 22,
                    ),
                  ),
                  HSpace.med,
                  Text(
                    value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class StatisticsWidget extends StatelessWidget {
//   const StatisticsWidget({
//     super.key,
//     required this.title,
//     required this.bgColor,
//     required this.value,
//   });
//   final String title;
//   final String value;
//   final Color bgColor;

//   double _getStatsWidth(BuildContext context) {
//     double sideMidPadding = kPaddingDefault * 4;
//     double allocatedWidth =
//         MediaQuery.of(context).size.width - sideMidPadding - 340;
//     return allocatedWidth / 4;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = _getStatsWidth(context);
//     return Container(
//       height: width * .5,
//       width: width,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//           color: tWhiteColor,
//           // color: bgColor.withValues(alpha: .22),
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     bgColor.withValues(alpha: .22),
//           //     bgColor.withValues(alpha: .22),
//           //     bgColor.withValues(alpha: .4),
//           //     bgColor.withValues(alpha: .6),
//           //     bgColor,
//           //   ],
//           // ),
//           borderRadius: BorderRadius.circular(kPaddingHalf),
//           border: Border.all(
//             color: bgColor,
//           )),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 30),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 100),
//               child: SvgPicture.asset(
//                 "assets/images/graph.svg",
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(bgColor, BlendMode.srcIn),
//               ),
//             ),
//           ),
//           //018 389 2111/ 018 285 4320
//           //34364544
//           //020429 1062 089
//           //Omogolo
//           //O mogolo

//           Padding(
//             padding: const EdgeInsets.all(kPaddingDefault),
//             child: IntrinsicHeight(
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(kPaddingQuarter),
//                     decoration: BoxDecoration(
//                       color: bgColor.withValues(alpha: .35),
//                       borderRadius: BorderRadius.circular(kPaddingHalf),
//                     ),
//                     child: Icon(
//                       Ionicons.school,
//                       color: bgColor,
//                     ),
//                   ),
//                   kHSpacingHalf,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         value,
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         title,
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
