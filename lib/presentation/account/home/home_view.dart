import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rich_ui/rich_ui.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/responsive.dart';
import '../../../models/app_stats_model.dart';
import '../../../styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: Text(
              "Dashboard",
              style: TextStyles.h1,
            ),
          ),
          responsiveStatsBuilder(context),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Insets.lg, vertical: Insets.med),
            padding: EdgeInsets.all(Insets.lg),
            decoration: BoxDecoration(
              color: tWhiteColor,
              borderRadius: BorderRadius.circular(kPaddingHalf),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kPaddingDefault),
                  child: Text(
                    "Recently Uploaded",
                    style: TextStyle(
                        color: tDarkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                RUiDataTableWidget(
                  columnsContainerDecoration: BoxDecoration(
                    // color: tWhiteColor,
                    color: tPrimaryColor.withOpacity(0.06),
                    // border:
                    //     const Border(bottom: BorderSide(color: Colors.grey)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(richPaddingHalf),
                        topRight: Radius.circular(richPaddingHalf)),
                  ),
                  columnsHeaderStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  columns: [
                    RUiDataTableColumn(title: "File Name"),
                    RUiDataTableColumn(title: "Type"),
                    RUiDataTableColumn(title: "Thumbs Up"),
                    RUiDataTableColumn(title: "Action", width: 100),
                  ],
                  rows: const [
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                    RUiDataTableRow(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget responsiveStatsBuilder(BuildContext context) {
    final items = tempStats();
    return Padding(
      padding: const EdgeInsets.all(kPaddingDefault),
      child: Column(
        children: [
          if (!Responsive.isMobile(context))
            statsBuilder(items)
          else ...[
            statsBuilder(items.sublist(0, 2)),
            kVSpacingQuarter,
            statsBuilder(items.sublist(2))
          ],
        ],
      ),
    );
  }

  Row statsBuilder(List<AppStatsModel> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        items.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                right: index != items.length - 1 ? kPaddingDefault : 0),
            child: StatisticsWidgetNew(
              title: items[index].title!,
              value: NumberFormat.compact().format(items[index].counts),
              icon: items[index].icon!,
              bgColor: items[index].color!,
            ),
          ),
        ),
      ),
      // children: items.map((e) {
      //   return StatisticsWidgetNew(
      //       title: e.title!,
      //       bgColor: e.color!,
      //       value: NumberFormat.compact().format(e.counts),
      //       icon: e.icon!);
      // }).toList(),
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
//           // color: bgColor.withOpacity(.22),
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     bgColor.withOpacity(.22),
//           //     bgColor.withOpacity(.22),
//           //     bgColor.withOpacity(.4),
//           //     bgColor.withOpacity(.6),
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
//                       color: bgColor.withOpacity(.35),
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
        color: tWhiteColor,
        borderRadius: BorderRadius.circular(kPaddingHalf),
        // boxShadow: const [
        //   BoxShadow(
        //       color: Color.fromARGB(26, 0, 0, 0),
        //       blurRadius: 4,
        //       spreadRadius: 0)
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingDefault),
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
                    padding: const EdgeInsets.all(kPaddingQuarter),
                    decoration: BoxDecoration(
                      color: bgColor.withOpacity(.35),
                      borderRadius: BorderRadius.circular(kPaddingHalf),
                    ),
                    child: Icon(
                      icon,
                      color: bgColor,
                      size: 22,
                    ),
                  ),
                  kHSpacingHalf,
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
