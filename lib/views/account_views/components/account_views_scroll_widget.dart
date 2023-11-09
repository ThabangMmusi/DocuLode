// import 'package:flutter/material.dart';

// import '../../../constants/app_constants.dart';
// import '../../../widgets/improved_scolling/flutter_improved_scrolling.dart';

// class ContentScrollView extends StatelessWidget {
//   const ContentScrollView(
//       {super.key, required this.scrollController, required this.child});
//   final ScrollController scrollController;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return ImprovedScrolling(
//         scrollController: scrollController,
//         enableMMBScrolling: true,
//         enableKeyboardScrolling: true,
//         enableCustomMouseWheelScrolling: true,
//         mmbScrollConfig: const MMBScrollConfig(
//           customScrollCursor: DefaultCustomScrollCursor(),
//         ),
//         keyboardScrollConfig: KeyboardScrollConfig(
//           homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
//             return const Duration(milliseconds: 100);
//           },
//           endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
//             return const Duration(milliseconds: 2000);
//           },
//         ),
//         customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
//           scrollAmountMultiplier: 4.0,
//           scrollDuration: Duration(milliseconds: 350),
//         ),
//         child: ScrollConfiguration(
//           behavior: const CustomScrollBehavior(),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: child,
//           ),
//         ));
//   }
// }

// class CustomScrollBehavior extends MaterialScrollBehavior {
//   const CustomScrollBehavior();

//   @override
//   Widget buildScrollbar(
//     BuildContext context,
//     Widget child,
//     ScrollableDetails details,
//   ) {
//     switch (getPlatform(context)) {
//       case TargetPlatform.linux:
//       case TargetPlatform.macOS:
//         return Scrollbar(
//           controller: details.controller,
//           thumbVisibility: true,
//           child: child,
//         );
//       case TargetPlatform.windows:
//         return Scrollbar(
//           controller: details.controller,
//           thumbVisibility: true,
//           radius: Radius.zero,
//           thickness: 16.0,
//           child: child,
//         );
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.iOS:
//         return child;
//     }
//   }
// }
