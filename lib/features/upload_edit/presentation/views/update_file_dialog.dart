import 'package:flutter/material.dart';
import 'package:its_shared/features/upload_edit/presentation/views/upload_edit_base.dart';

import '../../../../core/core.dart';
import '../../../../widgets/my_dialog_box.dart';

class UpdateFileDialog extends StatelessWidget {
  const UpdateFileDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomDialogNew(
      header: "Publish file",
      showCloseButton: true,
      content: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: UploadEditBase()),
    );
  }
}
