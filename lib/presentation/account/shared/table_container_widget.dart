// import 'package:flutter/material.dart';
// import 'package:rich_ui/rich_ui.dart';

// import '../../../styles.dart';

// class TableContainerWidget extends StatelessWidget {
//   const TableContainerWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(Insets.xl),
//       padding: EdgeInsets.all(Insets.lg),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.onPrimary,
//         borderRadius: Corners.lgBorder,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: Insets.med),
//             child: Text(
//               "Recently Uploaded",
//               style: TextStyles.title1,
//             ),
//           ),
//           RUiDataTableWidget(
//             columnsContainerDecoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary.withOpacity(.2),
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(Insets.sm),
//                   topRight: Radius.circular(Insets.sm)),
//               // border: Border(
//               //     bottom: BorderSide(
//               //         color: Theme.of(context).colorScheme.inverseSurface))
//             ),
//             columnsHeaderStyle: const TextStyle(
//                 color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
//             columns: [
//               RUiDataTableColumn(title: "File Name"),
//               RUiDataTableColumn(title: "Type"),
//               RUiDataTableColumn(title: "Thumbs Up"),
//               RUiDataTableColumn(title: "Action", width: 100),
//             ],
//             rows: const [
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//               RUiDataTableRow(children: [
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//                 Text("data"),
//               ]),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
