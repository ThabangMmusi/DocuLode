// import 'package:flutter/material.dart';

// import '../constants/app_constants.dart';
// import '../constants/app_enums.dart';
// import 'my_button.dart';

// class MyAlertDialog extends StatelessWidget {
//   final AlertTypes type;
//   final String message;
//   final VoidCallback? onCancel;

//   const MyAlertDialog(
//       {super.key, required this.type, required this.message, this.onCancel});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }

//   Widget dialogContent(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: const <BoxShadow>[
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 0.0,
//               offset: Offset(0.0, 0.0),
//             ),
//           ]),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 5),
//           alertIcon(),
//           const SizedBox(height: 10),
//           Text(
//             message,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (type == AlertTypes.information)
//                 MyButton(
//                   isRed: true,
//                   onPressed: () {
//                     Navigator.pop(context);
//                     onCancel!.call();
//                   },
//                   text: "back",
//                 ),
//               if (type == AlertTypes.information) kHSpacingDefault,
//               MyButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 text: "Okay",
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget alertIcon() {
//     const double iconSize = 52;
//     if (type == AlertTypes.success) {
//       return const Icon(
//         Icons.check_circle_outline,
//         color: Colors.green,
//         size: iconSize,
//       );
//     } else if (type == AlertTypes.information) {
//       return Icon(
//         Icons.info_outline,
//         color: Colors.blue[900],
//         size: iconSize,
//       );
//     }

//     return const Icon(
//       Icons.error_outline,
//       color: Colors.red,
//       size: iconSize,
//     );
//   }
// }
