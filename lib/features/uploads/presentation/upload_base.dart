// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:its_shared/styles.dart';
// import 'package:rich_ui/rich_ui.dart';

// import '../../../commands/files/pick_file_command.dart';
// import '../../../widgets/my_button.dart';
// import '../../upload_progress/presentation/bloc/upload_progress_bloc.dart';
// import '../../upload_progress/upload_progress.dart';

// class UploadFileBase extends StatefulWidget {
//   const UploadFileBase({
//     super.key,
//   });

//   @override
//   State<UploadFileBase> createState() => _UploadFileBaseState();
// }

// class _UploadFileBaseState extends State<UploadFileBase> {
//   late TextEditingController title;
//   late ListItem module;
//   late ListItem type;
//   @override
//   void initState() {
//     title = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     title.dispose();
//     super.dispose();
//   }

//   late List<PickedFile>? pickedImage;
//   @override
//   Widget build(BuildContext context) {
//     Color primaryColor = Theme.of(context).colorScheme.primary;
//     // Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
//     // Color onPrimaryContainer = Theme.of(context).colorScheme.tertiaryContainer;
//     return BlocBuilder<UploadProgressBloc, UploadState>(
//       builder: (context, state) {
//         if (!state.uploading) {
//           return Column(children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: Insets.lg),
//               decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(.1),
//                   borderRadius: Corners.medBorder,
//                   border: Border.all(color: primaryColor)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Ionicons.arrow_up_circle,
//                   ),
//                   VSpace.sm,
//                   Text("Drag and Drop file here Or", style: TextStyles.title2),
//                   // Text("or", style: TextStyles.title2),
//                   VSpace.med,
//                   AppButton(
//                     title: 'Select file',
//                     onTap: () async {
//                       pickedImage =
//                           await PickFileCommand().run(enableCamera: false);
//                       if (pickedImage != null) {
//                         setState(() {
//                           title.text = pickedImage!.first.name;
//                         });
//                       }
//                     },
//                   )
//                 ],
//               ),
//             ),
//             VSpace.lg,
//             RUiTextField(
//                 controller: title,
//                 borderRadius: Corners.med,
//                 label: "File Name",
//                 onChanged: (value) {}),
//             // VSpace.med,
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Expanded(
//                   child: RUiDropDownList(
//                     radius: Corners.med,
//                     listItems: const [
//                       ListItem("Question Paper", value: "QP"),
//                       ListItem("Memorandum", value: "MEMO"),
//                       ListItem("Notes", value: "NOTS"),
//                     ],
//                     value: "QP",
//                     label: "Document Type",
//                     onChange: (value) => 2,
//                   ),
//                 ),
//                 HSpace.lg,
//                 Expanded(
//                   child: RUiDropDownList(
//                     radius: Corners.med,
//                     listItems: const [
//                       ListItem("Question Paper"),
//                       ListItem("Memorandum"),
//                       ListItem("Notes"),
//                     ],
//                     label: "Module",
//                     onChange: (value) {},
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Spacer(),
//                 AppButton(
//                   title: 'Upload',
//                   iconToRight: true,
//                   icon: Ionicons.arrow_up_circle_outline,
//                   onTap: () async {
//                     // UploadFileCommand().run(files: pickedImage!);
//                     // Trigger file upload event
//                     BlocProvider.of<UploadProgressBloc>(context)
//                         .add(UploadFiles(pickedImage!));
//                   },
//                 )
//               ],
//             )
//           ]);
//         } else if (state.uploading) {
//           return const UploadProgressView();
//           // } else if (state is UploadSuccess) {
//           //   return ListView.builder(
//           //     itemCount: state.downloadUrls.length,
//           //     itemBuilder: (context, index) {
//           //       return ListTile(
//           //         title: Text('File ${index + 1}'),
//           //         subtitle: Text(state.downloadUrls[index]),
//           //       );
//           //     },
//           //   );
//           // } else if (state is UploadFailure) {
//           //   return Center(
//           //     child: Text('Error: ${state.error}'),
//           //   );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
