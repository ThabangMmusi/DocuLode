import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool isRed;
  final bool excludeFocus;

  const MyButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.isEnabled = true,
      this.isRed = false,
      this.excludeFocus = false});

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      excluding: excludeFocus,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: Stack(
          children: [
            Visibility(
              visible: !isLoading,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: isEnabled
                        ? isRed
                            ? Colors.red
                            : tPrimaryColor
                        : Colors.grey,
                    disabledForegroundColor: tSecondaryColor.withOpacity(0.38),
                    disabledBackgroundColor: tSecondaryColor.withOpacity(0.12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: kPaddingDefault / 2,
                      horizontal: kPaddingDefault),
                  child: Text(
                    text.toUpperCase(),
                  ),
                ),
                // color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 40,
              height: 50,
              child: Visibility(
                visible: isLoading,
                child: const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
