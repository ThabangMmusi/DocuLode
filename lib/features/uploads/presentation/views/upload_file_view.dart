import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/commands/files/pick_file_command.dart';
import 'package:its_shared/styles.dart';

import '../../../../widgets/my_button.dart';
import '../../../../presentation/account/shared/shared.dart';
import '../../../upload_progress/presentation/bloc/upload_progress_bloc.dart';

class UploadFileView extends StatelessWidget {
  const UploadFileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ViewTitle(
                title: "Uploads",
              ),
              const Spacer(),
              AppButton(
                title: 'Upload',
                icon: Ionicons.add_circle_outline,
                iconToRight: true,
                // onTap: () => showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (context) => const UploadFileDialog(),
                // ),
                onTap: () async {
                  List<PickedFile> pickedImage =
                      await PickFileCommand().run(enableCamera: false);
                  if (pickedImage.isNotEmpty) {
                    BlocProvider.of<UploadProgressBloc>(context)
                        .add(UploadingFiles(pickedImage));
                  }
                },
              ),
              HSpace.lg
            ],
          ),
          const TableContainerWidget(),
        ],
      ),
    );
  }
}
