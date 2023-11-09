import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/app_textfield.dart';

class UploadFileView extends StatelessWidget {
  const UploadFileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 238,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
        decoration: BoxDecoration(
            color: tPrimaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(kPaddingHalf),
            border: Border.all(color: tPrimaryColor)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Ionicons.cloud_upload,
            ),
            Text("Add new file")
          ],
        ),
      ),
      kVSpacingDefault,
      TextButton(
          onPressed: () async {
            // final user =
            //     context.select((AuthBloc bloc) => bloc.state.authUser);
            // final token = await user!.getIdToken();
            // print(token);
          },
          child: const Text("Token")),
      AppTextField(
          borderRadius: kPaddingHalf, label: "File Name", onChanged: (value) {})
    ]);
  }
}
