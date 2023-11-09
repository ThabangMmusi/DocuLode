// import 'package:flutter/material.dart';

// import '../constants/app_constants.dart';
// import '../constants/responsive.dart';
// import '../models/cmi.dart';
// import '../routes/app_pages.dart';

// class SideMenuNew extends StatelessWidget {
//   const SideMenuNew({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<SideMenuItemModel> menuItems = [
//       // Dashboard
//       SideMenuItemModel(
//         title: "Dashboard",
//         iconData: Icons.home_max_outlined,
//         onPressed: () {
//           // Get.rootDelegate.toNamed(Routes.home);
//         },
//       ),
//       // if (AuthController.to.isOwner.isTrue)

//       //   // Membership
//       //   SideMenuItemModel(
//       //     title: "Membership",
//       //     iconData: IconVectorPath.users,
//       //     onPressed: () {
//       //       Get.rootDelegate.toNamed(Routes.membershipList);
//       //     },
//       //   ),
//       // if (AuthController.to.isOwner.isFalse)

//       //   // New Membership
//       //   SideMenuItemModel(
//       //     iconData: IconVectorPath.user,
//       //     title: 'New Membership',
//       //     onPressed: () {
//       //       Get.dialog(
//       //         NewMemberDialog(MembershipDialogTypes.create),
//       //         barrierDismissible: false,
//       //         // arguments: RoutingParameters.premiums
//       //       );
//       //     },
//       //   ),

//       // if (AuthController.to.isOwner.isFalse)
//       //   // view Membership
//       //   SideMenuItemModel(
//       //     iconData: IconVectorPath.edit,
//       //     title: 'View Membership',
//       //     onPressed: () {
//       //       Get.dialog(
//       //         NewMemberDialog(MembershipDialogTypes.view),
//       //         barrierDismissible: false,
//       //         // arguments: RoutingParameters.premiums
//       //       );
//       //     },
//       //   ),

//       // if (AuthController.to.isOwner.isFalse)
//       //   // Membership Premium
//       //   SideMenuItemModel(
//       //     iconData: IconVectorPath.money,
//       //     title: 'Membership Premium',
//       //     onPressed: () {
//       //       Get.dialog(
//       //         NewMemberDialog(MembershipDialogTypes.premium),
//       //         barrierDismissible: false,
//       //         // arguments: RoutingParameters.premiums
//       //       );
//       //     },
//       //   ),

//       // // Insurance Types
//       // SideMenuItemModel(
//       //   title: "Insurance Types",
//       //   iconData: IconVectorPath.list,
//       //   onPressed: () {
//       //     Get.rootDelegate.toNamed(Routes.insuranceList);
//       //   },
//       // ),

//       // if (AuthController.to.isOwner.isTrue)
//       //   // Transactions
//       //   SideMenuItemModel(
//       //     iconData: IconVectorPath.stats,
//       //     title: 'Payments History',
//       //     onPressed: () {
//       //       Get.rootDelegate.toNamed(Routes.paymentsList);
//       //     },
//       //   ),

//       // // Reports
//       // // SideMenuItemModel(
//       // //   index: 4,
//       // //   title: "Reports",
//       // //   svgSrc: "assets/icons/Bell.svg",
//       // //   onPressed: () {
//       // //     Get.rootDelegate.toNamed(Routes.insuranceTnC);
//       // //   },
//       // // ),

//       // if (AuthController.to.isOwner.isTrue)
//       //   SideMenuItemModel(
//       //     title: "Settings",
//       //     iconData: IconVectorPath.settings,
//       //     items: const [
//       //       IconDrawerListTile(
//       //         svgSrc: IconVectorPath.users,
//       //         title: 'Employees',
//       //       ),
//       //       IconDrawerListTile(
//       //         svgSrc: IconVectorPath.list,
//       //         title: 'Offices',
//       //       ),
//       //       IconDrawerListTile(
//       //         svgSrc: IconVectorPath.home,
//       //         title: 'Business Details',
//       //       ),
//       //     ],
//       //     onItemPress: (val) {
//       //       switch (val) {
//       //         case 0:
//       //           Get.rootDelegate.toNamed(Routes.employeesList);
//       //           break;
//       //         case 1:
//       //           // Get.lazyPut(() => OfficeController());
//       //           // Future.delayed(const Duration(milliseconds: 150));
//       //           Get.rootDelegate.toNamed(Routes.officesList);
//       //           break;
//       //         case 2:
//       //           Get.rootDelegate.toNamed(Routes.company);
//       //           break;
//       //       }
//       //     },
//       //   ),

//       // SideMenuItemModel(
//       //   canBeSelected: false,
//       //   title: "Log Out",
//       //   iconData: IconVectorPath.login,
//       //   onPressed: () async {
//       //     AuthController.to.signOut();
//       //   },
//       // ),
//     ];

//     return Container(
//       margin: const EdgeInsets.all(kPaddingDefault),
//       constraints:
//           BoxConstraints(maxWidth: !Responsive.isTablet(context) ? 250 : 64),
//       // height: 700,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(kPaddingHalf)),
//       child: Column(
//         children: [
//           // Padding(
//           //   padding: const EdgeInsets.only(
//           //       top: kPaddingDefault, bottom: kPaddingHalf),
//           //   child: Column(
//           //     children: [
//           //       SvgPicture.asset(
//           //         SvgLogosPath.logoDark,
//           //         width: !Responsive.isDesktop(context) ? 41 : 48,
//           //       ),
//           //       kVSpacingQuarter,
//           //       if (Responsive.isDesktop(context))
//           //         Text(
//           //           "My Soxiety v.1.0".toUpperCase(),
//           //           style: Theme.of(context).textTheme.headline6,
//           //         )
//           //     ],
//           //   ),
//           // ),

//           Expanded(
//               child: ListView.builder(
//                   itemCount: menuItems.length,
//                   itemBuilder: (listContext, index) => MySideMenuButton(
//                       canBeSelected: menuItems[index].canBeSelected,
//                       onPressed: menuItems[index].onPressed,
//                       items: menuItems[index].items,
//                       onItemPress: (val) {
//                         menuItems[index].onItemPress!.call(val);
//                         controller.setSelected(index);
//                       },
//                       index: index,
//                       title: menuItems[index].title,
//                       iconData: menuItems[index].iconData))),
//         ],
//       ),
//     );
//   }
// }

// class DrawerTileModel {
//   final String title;
//   final String svgSrc;

//   DrawerTileModel({required this.title, required this.svgSrc});
// }

// class IconDrawerListTile extends StatefulWidget {
//   const IconDrawerListTile({
//     Key? key,
//     required this.title,
//     required this.iconData,
//   }) : super(key: key);

//   final String title;
//   final IconData iconData;
//   @override
//   State<IconDrawerListTile> createState() => _IconDrawerListTileState();
// }

// class _IconDrawerListTileState extends State<IconDrawerListTile> {
//   bool _hovered = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (event) {
//         setState(() {
//           _hovered = true;
//         });
//       },
//       onExit: (event) {
//         setState(() {
//           _hovered = false;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(kPaddingDefault / 2),
//         width: Get.width,
//         color: _hovered ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
//         height: 40,
//         child: Row(
//           children: [
//             if (!Responsive.isMobile(context))
//               Padding(
//                 padding: const EdgeInsets.only(left: kPaddingQuarter),
//                 child: Icon(
//                   widget.iconData,
//                   color: Colors.black,
//                 ),
//               ),
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: 2,
//                   left: Responsive.isMobile(context)
//                       ? kPaddingQuarter
//                       : kPaddingDefault),
//               child: Text(
//                 widget.title,
//                 style: const TextStyle(color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
