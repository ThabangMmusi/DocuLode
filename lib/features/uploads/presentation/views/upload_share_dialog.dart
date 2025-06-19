import 'package:doculode/config/index.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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
                  style: TextStyles.headlineMedium,
                  text: "Share Document",
                ),
                VSpace.lg,
                StyledTextInput(
                  readOnly: true,
                  initialValue: url,
                ),
                VSpace.med,
                SecondaryBtn(
                  // isCompact: true,
                  label: "Copy",
                  onPressed: () async =>
                      await Clipboard.setData(ClipboardData(text: url)),
                ),
              ],
            ),
          )),
    );
  }
}
