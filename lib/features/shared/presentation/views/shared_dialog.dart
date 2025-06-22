import 'package:doculode/app/config/index.dart';

import 'package:flutter/material.dart';

import '../../../../core/widgets/my_dialog_box.dart';
import 'base_shared_view.dart';

class SharedFileDialog extends StatelessWidget {
  const SharedFileDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomDialogNew(
      showCloseButton: true,
      content: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 201),
          child: Padding(
            padding: EdgeInsets.only(top: Insets.xl),
            child: const BaseSharedView(),
          )),
    );
  }
}
