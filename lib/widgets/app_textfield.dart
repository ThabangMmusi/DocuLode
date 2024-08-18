import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';

class AppTextField extends StatefulWidget {
  final String? initialValue;
  final String? hint;
  final String? label;
  final Widget? trailing;
  final int textLength;
  final FormFieldValidator<String>? fieldValidator;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final TextCapitalization? textCaps;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? isPassword;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool readOnly;
  final AutovalidateMode autoValidate;
  final Iterable<String>? autofillHints;
  final double? borderRadius;
  final Function()? onTap;
  final bool big;
  final bool? enabled;
  final String? helperText;

  const AppTextField({
    super.key,
    this.label,
    this.textLength = 50,
    this.fieldValidator,
    required this.onChanged,
    this.onSubmit,
    this.focusNode,
    this.textCaps,
    this.inputFormatter,
    this.keyboardType,
    this.hint,
    this.controller,
    this.isPassword,
    this.textInputAction,
    this.suffix,
    this.prefix,
    this.readOnly = false,
    this.initialValue,
    this.onSaved,
    this.autofillHints,
    this.onTap,
    this.autoValidate = AutovalidateMode.disabled,
    this.borderRadius,
    this.big = false,
    this.enabled,
    this.trailing,
    this.prefixIcon,
    this.helperText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _viewPassword = true;
  late AppTextField oldWidget;

  late String? _baseValue;
  @override
  void initState() {
    _baseValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oldWidget = widget;
    bool isPassword = widget.isPassword ?? false;
    TextInputAction textInputAction =
        widget.textInputAction ?? TextInputAction.next;

    var textStyle = TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 11,
        color: Colors.red[700],
        height: 0.7);
    return FormField(validator: (value) {
      if (widget.controller == null) {
        String? currentValue;
        if (_baseValue != null || widget.initialValue != null) {
          if (_baseValue == null && widget.initialValue != null) {
            currentValue = widget.initialValue;
          } else if (_baseValue != null) {
            currentValue = _baseValue;
          }
        }
        return widget.fieldValidator!.call(currentValue);
      } else {
        if (widget.fieldValidator != null) {
          return widget.fieldValidator!.call(widget.controller!.text);
        }
      }
      return null;
    }, builder: (formFieldState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.label != null) Text(widget.label!),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
          const SizedBox(height: 4),
          TextFormField(
            onTap: widget.onTap,
            autofillHints: widget.autofillHints,
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            obscureText: isPassword ? _viewPassword : false,
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLength: widget.textLength,
            // validator: widget.fieldValidator,
            minLines: 1,
            maxLines: 1,
            autovalidateMode: widget.autoValidate,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatter,
            textInputAction: textInputAction,
            textCapitalization: widget.textCaps ?? TextCapitalization.words,
            style: widget.big
                ? Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 36, fontWeight: FontWeight.bold)
                : null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                  kPaddingDefault * .7, 0, kPaddingDefault * .7, 0),
              constraints: BoxConstraints(
                  maxHeight: (widget.helperText != null ? 52 : 42) +
                      (widget.big ? 38 : 0)),
              hintText: widget.hint,
              counter: null,
              errorMaxLines: 1,
              helperText: widget.helperText,
              helperMaxLines: 1,
              helperStyle: textStyle,
              errorStyle: textStyle,
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
              filled: widget.enabled != null && widget.enabled != false,
              fillColor: Theme.of(context).primaryColorDark,
              suffixIcon: isPassword || widget.suffix != null
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
              // labelText: widget.label,
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: borderRadiusMethod(),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    Theme.of(context).inputDecorationTheme.enabledBorder != null
                        ? Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder!
                            .borderSide
                        : const BorderSide(color: Colors.grey),
                borderRadius: borderRadiusMethod(),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: borderRadiusMethod(),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: borderRadiusMethod(),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: borderRadiusMethod(),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
                borderRadius: borderRadiusMethod(),
              ),
            ),
            onChanged: (mainBaseValue) {
              _baseValue = mainBaseValue;
              if (widget.onChanged != null) {
                widget.onChanged!.call(mainBaseValue);
              }
            },
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onSubmit,
          ),
          if (!formFieldState.hasError)
            const SizedBox(
              height: 15,
            ),
          if (formFieldState.hasError)
            // ErrorMessageWidget(errorMessage: formFieldState.errorText)
            Text(formFieldState.errorText!)
        ],
      );
    });
  }

  BorderRadius borderRadiusMethod() => widget.borderRadius != null
      ? BorderRadius.all(Radius.circular(widget.borderRadius!))
      : BorderRadius.zero;
}
