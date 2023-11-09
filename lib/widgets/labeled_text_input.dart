import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_utils/string_utils.dart';
import '../constants/app_constants.dart';
import '../styles.dart';
import 'ui_text.dart';

class LabeledTextInput extends StatefulWidget {
  const LabeledTextInput(
      {super.key,
      this.text,
      this.label = "",
      this.onChanged,
      this.onSubmit,
      this.style,
      this.labelStyle,
      this.numLines = 1,
      this.hintText,
      this.controller,
      this.autofillHints,
      this.obscureText = false,
      this.autoFocus = false,
      this.maxLength,
      this.filled = false,
      this.radius = Corners.lgBorder,
      this.suffix,
      this.prefix,
      this.prefixIcon});

  final String label;
  final String? text;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final int numLines;
  final int? maxLength;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmit;
  final String? hintText;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autoFocus;
  final bool filled;
  final BorderRadius radius;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;

  @override
  _LabeledTextInputState createState() => _LabeledTextInputState();
}

class _LabeledTextInputState extends State<LabeledTextInput> {
  bool _viewPassword = true;
  @override
  Widget build(BuildContext context) {
    VisualDensity visualDensity = Theme.of(context).visualDensity;
    return Theme(
      data: Theme.of(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label + spacing
          if (StringUtils.isNotEmpty(widget.label)) ...[
            UiText(
                text: widget.label,
                style: widget.labelStyle ?? TextStyles.caption),
            kVSpacingHalf,
          ],
          // TextField
          TextFormField(
            controller: widget.controller,
            autofillHints: widget.autofillHints,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
            ],
            onFieldSubmitted: widget.onSubmit,
            onChanged: widget.onChanged,
            initialValue: widget.text,
            style: widget.style ?? TextStyles.body2,
            autofocus: widget.autoFocus,
            minLines: widget.numLines,
            maxLines: widget.numLines,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
                hintText: widget.hintText ?? "",
                hintStyle: (widget.style ?? TextStyles.body2)
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
                prefix: widget.prefix,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.obscureText || widget.suffix != null
                    ? ExcludeFocus(
                        child: widget.suffix != null
                            ? widget.suffix!
                            : SizedBox(
                                height: 20,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _viewPassword = !_viewPassword;
                                      });
                                    },
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withAlpha(_viewPassword ? 75 : 255),
                                    icon: const Icon(
                                      Icons.visibility,
                                      size: 18,
                                    ))),
                      )
                    : null,
                filled: widget.filled,
                fillColor: Theme.of(context).colorScheme.background,
                enabledBorder: OutlineInputBorder(
                    borderRadius: Corners.lgBorder,
                    borderSide: BorderSide(
                        color: widget.filled
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.tertiary,
                        width: 1,
                        style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: Corners.lgBorder,
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                        style: BorderStyle.solid)),
                contentPadding: EdgeInsets.only(
                  left: Insets.med,
                  right: Insets.med,
                  top: 0,
                  bottom: 0,
                ),
                constraints: const BoxConstraints(maxHeight: 42),
                isDense: false),
          ),
        ],
      ),
    );
  }
}
