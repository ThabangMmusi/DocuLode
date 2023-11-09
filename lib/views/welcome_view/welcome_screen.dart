// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../constants/app_constants.dart';
// import '../../controllers/org_controller.dart';
// import '../../routes/app_pages.dart';
// import '../../widgets/my_button.dart';

// class WelcomeScreen extends GetView<OrgController> {
//   WelcomeScreen({Key? key}) : super(key: key);
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Column(children: const [
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     SvgPicture.asset(
//                     //       SvgLogosPath.logoDark,
//                     //       width: 60,
//                     //     ),
//                     //     kHSpacingDefault,
//                     //     SvgPicture.asset(
//                     //       SvgLogosPath.logoDarkName,
//                     //       height: 30,
//                     //     )
//                     //   ],
//                     // ),
//                     // kVSpacingDefault,
//                     // Image.asset(
//                     //   'assets/images/welcome_bg.png',
//                     //   width: 500,
//                     // ),
//                     // const SizedBox(
//                     //   height: kPaddingDefault / 2,
//                     // ),
//                     Text(
//                       'Welcome to\nmi Inventory',
//                       style:
//                           TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Where managing your inventory is made easy!',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                     )
//                   ]),
//                   kVSpacingDefault,
//                   buildBusinessNameUi(),
//                   kVSpacingDefault,
//                   MyButton(text: 'Continue', onPressed: _buttonPressed),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   void _buttonPressed() async {
//     if (_formKey.currentState!.validate()) {
//       await controller.createOrgInFirestore();
//       Get.rootDelegate.offNamed(Routes.home);
//     }
//   }

//   Widget buildBusinessNameUi() {
//     controller.firstFocus.requestFocus();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(kPaddingDefault),
//           child: TextFormField(
//             focusNode: controller.firstFocus,
//             controller: OrgController.to.nameController,
//             maxLength: 25,
//             minLines: 1,
//             maxLines: 1,
//             style: const TextStyle(
//               fontSize: 26,
//             ),
//             onFieldSubmitted: (val) {
//               _buttonPressed();
//             },
//             decoration: InputDecoration(
//               constraints: const BoxConstraints(maxWidth: 460),
//               labelText: "Business Name",
//               counterText: "",
//               border: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Colors.grey.withAlpha(80), width: 1),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(8),
//                 ),
//               ),
//             ),
//             validator: (value) {
//               if (value != null) {
//                 if (value.isEmpty) {
//                   // FormStepperController.to.errorMsg.value =
//                   return "Business Name is required";
//                 } else if (value.length < 3) {
//                   // FormStepperController.to.errorMsg.value =
//                   return "Business Name cannot be less than 3 chars";
//                 }
//               }
//               return null;
//             },
//             onChanged: (value) {
//               // FormStepperController.to.checkedErrors.value = true;
//               // if (value == "" || value.length < 3) {
//               //   FormStepperController.to.hasError.value = true;
//               //   if (value.isEmpty) {
//               //     FormStepperController.to.errorMsg.value =
//               //         "Business Name is required";
//               //   } else {
//               //     FormStepperController.to.errorMsg.value =
//               //         "Business Name is cannot be less than three(3) characters";
//               //   }
//               // } else {
//               //   FormStepperController.to.hasError.value = false;
//               // }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
