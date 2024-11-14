import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/labeled_text_input.dart';
import 'package:its_shared/widgets/ui_text.dart';
import 'package:flutter/services.dart';

import '../../../../widgets/my_dialog_box.dart';

class UpdateShareDialog extends StatelessWidget {
  const UpdateShareDialog(
    this.url, {
    super.key,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return CustomDialogNew(
      showCloseButton: true,
      content: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 191),
          child: Padding(
            padding: EdgeInsets.only(top: Insets.xl),
            child: Column(
              children: [
                UiText(
                  style: TextStyles.h2,
                  text: "Share Document",
                ),
                VSpace.lg,
                LabeledTextInput(
                  readOnly: true,
                  text: url,
                ),
                VSpace.med,
                SecondaryBtn(
                  // isCompact: true,
                  label: "Copy",
                  cornerRadius: 4,
                  onPressed: () async =>
                      await Clipboard.setData(ClipboardData(text: url)),
                ),
              ],
            ),
          )),
    );
  }
}
