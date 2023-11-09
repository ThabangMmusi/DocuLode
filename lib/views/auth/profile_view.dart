// /import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';
// import '../../constants/app_constants.dart';
// import '../../controllers/auth/auth_controller.dart';
// import '../../routes/app_pages.dart';

// class ProfileView extends GetWidget<AuthController> {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(
//           () => Column(
//             children: [
//               Stack(
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         const CircleAvatar(
//                           radius: 60,
//                           child: Icon(
//                             Ionicons.person_add_outline,
//                             size: 40,
//                           ),
//                         ),
//                         kVSpacingDefault,
//                         Text(
//                           controller.firestoreUser.value!.names!,
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                         kVSpacingQuarter,
//                         Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: kPaddingQuarter,
//                                 horizontal: kPaddingHalf),
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.circular(kPaddingDefault),
//                                 color: Theme.of(context).primaryColor),
//                             child: Text(
//                               controller.isOwner.isTrue ? "Employee" : "Owner",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium!
//                                   .copyWith(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                             )),
//                         kVSpacingDefault,
//                       ],
//                     ),
//                   ),
//                   const BackButton()
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(kPaddingDefault),
//                   height: double.infinity,
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(kPaddingDefault * 1.5),
//                           topRight: Radius.circular(kPaddingDefault * 1.5)),
//                       color: Colors.white),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         _buildButton(
//                             context, Ionicons.person, "Edit Profile", () {}),
//                         Container(
//                           height: 2,
//                           width: double.maxFinite,
//                           color: Colors.grey[300],
//                         ),
//                         if (Get.rootDelegate.currentConfiguration!.currentPage!
//                                 .name !=
//                             Routes.productList)
//                           _buildButton(
//                               context, Ionicons.fast_food, "Stock Management",
//                               () {
//                             Get.rootDelegate.offAndToNamed(Routes.productList);
//                           }),
//                         if (Get.rootDelegate.currentConfiguration!.currentPage!
//                                 .name !=
//                             Routes.home)
//                           _buildButton(
//                               context, Ionicons.fast_food, "Sell Products", () {
//                             Get.rootDelegate.offAndToNamed(Routes.home);
//                           }),
//                         _buildButton(context, Ionicons.arrow_redo,
//                             "Return Product", () {}),
//                         _buildButton(context, Ionicons.people,
//                             "Staff Management", () {}),
//                         _buildButton(context, Ionicons.storefront,
//                             "Store Details", () {}),
//                         Container(
//                           height: 2,
//                           width: double.maxFinite,
//                           color: Colors.grey[300],
//                         ),
//                         _buildButton(context, Ionicons.key, "Logout", () {}),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(
//       BuildContext context, IoniconsData icon, String title, Function() onTap) {
//     return Padding(
//       padding: const EdgeInsets.only(top: kPaddingHalf),
//       child: InkWell(
//           onTap: () {
//             onTap.call();
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundColor: Theme.of(context).primaryColor,
//                   foregroundColor: Colors.white,
//                   child: Icon(
//                     icon,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(kPaddingHalf),
//                   child: Text(title,
//                       style: Theme.of(context).textTheme.titleMedium),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
