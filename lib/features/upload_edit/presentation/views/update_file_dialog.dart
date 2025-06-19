import 'package:doculode/config/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/my_dialog_box.dart';
import '../bloc/upload_edit_bloc.dart';
import 'upload_edit_view.dart';

class UpdateFileDialog extends StatelessWidget {
  const UpdateFileDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final state = context.watch<UploadEditBloc>().state;

    return CustomDialogNew(
      // header: "Publish file",
      initializingText: "Loading Modules",
      isInitializing: state.status == UploadEditStatus.initial,
      isLoading: state.status == UploadEditStatus.loading,
      loadingText: "Saving...",
      showCloseButton: true,
      content: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 451),
          child: Padding(
            padding: EdgeInsets.only(top: Insets.xl),
            child: const UploadEditView(),
          )),
    );
  }
}
