import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_utils/string_utils.dart';
import '../styles.dart';
import 'ui_text.dart';

class LabeledTextInput extends StatefulWidget {
  const LabeledTextInput({
    super.key,
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
    this.readOnly = false,
    this.radius = Corners.lgBorder,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.focusNode,
  });

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
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  State<LabeledTextInput> createState() => _LabeledTextInputState();
}

class _LabeledTextInputState extends State<LabeledTextInput> {
  bool _viewPassword = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label + spacing
        if (StringUtils.isNotEmpty(widget.label)) ...[
          UiText(
              text: widget.label,
              style: widget.labelStyle ?? theme.textTheme.bodyMedium),
          VSpace.xs,
        ],
        // TextField
        TextFormField(
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          textInputAction: TextInputAction.done,
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
              fillColor: colorScheme.tertiary,
              enabledBorder: OutlineInputBorder(
                  borderRadius: Corners.smBorder,
                  borderSide: BorderSide(
                      color: colorScheme.tertiary,
                      width: 1,
                      style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: Corners.smBorder,
                  borderSide: BorderSide(
                      color: colorScheme.primary,
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
    );
  }
}
