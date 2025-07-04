import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledTextInput extends StatefulWidget {
  const StyledTextInput({
    super.key,
    this.initialValue,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.style,
    this.labelStyle,
    this.numLines = 1,
    this.hintText,
    this.controller,
    this.autofillHints,
    this.obscureText = false,
    this.autoFocus = false,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.errorText,
  });

  final String? label;
  final String? initialValue;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final int numLines;
  final int? maxLength;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final String? hintText;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final bool enabled;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  @override
  State<StyledTextInput> createState() => _StyledTextInputState();
}

class _StyledTextInputState extends State<StyledTextInput> {
  TextEditingController? _internalController;
  late bool _isPasswordVisible;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    }
    _isPasswordVisible = !widget.obscureText;

    _internalController?.addListener(() {
      if (mounted && widget.onChanged != null) {
        widget.onChanged!(_internalController!.text);
      }
    });
  }

  @override
  void didUpdateWidget(StyledTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _internalController?.removeListener(_onInternalControllerChange);
      _internalController =
          TextEditingController.fromValue(oldWidget.controller!.value);
      _internalController?.addListener(_onInternalControllerChange);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _internalController?.removeListener(_onInternalControllerChange);
      _internalController?.dispose();
      _internalController = null;
    }
    if (widget.controller == null &&
        widget.initialValue != oldWidget.initialValue &&
        _internalController != null) {
      if (_internalController!.text != widget.initialValue) {
        _internalController!.text = widget.initialValue ?? '';
      }
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _isPasswordVisible = !widget.obscureText;
    }
  }

  void _onInternalControllerChange() {
    if (mounted && widget.onChanged != null) {
      widget.onChanged!(_internalController!.text);
    }
  }

  @override
  void dispose() {
    _internalController?.removeListener(_onInternalControllerChange);
    _internalController?.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final InputDecorationTheme themeInputDecoration =
        theme.inputDecorationTheme;

    bool hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    Color? currentFillColor = themeInputDecoration.fillColor;
    Color? passwordToggleColor =
        themeInputDecoration.suffixIconColor ?? colorScheme.onSurfaceVariant;

    if (widget.readOnly) {
      currentFillColor = colorScheme.onSurface.withValues(alpha: 0.05);
    } else if (hasError) {
      currentFillColor = colorScheme.errorContainer.withValues(alpha: 0.20);
      passwordToggleColor = colorScheme.error;
    } else if (!widget.enabled) {
      currentFillColor = colorScheme.onSurface.withValues(alpha: 0.04);
    }

    bool isFilled = themeInputDecoration.filled;

    final InputDecoration effectiveDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: widget.hintText != null
          ? (widget.style ??
                  TextStyles.bodyMedium.copyWith(color: colorScheme.onSurface))
              .copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7))
          : null,
      prefix: widget.prefixWidget,
      prefixIcon: widget.prefixIcon,
      errorText: widget.errorText,
      suffixIcon: widget.suffixWidget ??
          (widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: IconSizes.sm,
                  ),
                  onPressed: _togglePasswordVisibility,
                  color: passwordToggleColor,
                )
              : null),
      fillColor: currentFillColor,
      filled: isFilled,
    );

    List<TextInputFormatter> formatters =
        List<TextInputFormatter>.from(widget.inputFormatters ?? []);
    if (widget.maxLength != null &&
        !formatters.any((f) => f is LengthLimitingTextInputFormatter)) {
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label?.isNotEmpty ?? false) ...[
          UiText(
            text: widget.label!,
            style: widget.labelStyle ??
                textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: hasError
                        ? colorScheme.error
                        : (theme.textTheme.labelLarge?.color ??
                            colorScheme.onSurface)),
          ),
          VSpace.xs,
        ],
        TextFormField(
          controller: _effectiveController,
          focusNode: widget.focusNode,
          style: widget.style ??
              TextStyles.bodyMedium.copyWith(color: colorScheme.onSurface),
          decoration: effectiveDecoration,
          obscureText: widget.obscureText && !_isPasswordVisible,
          autofocus: widget.autoFocus,
          maxLength: widget.maxLength,
          minLines: widget.numLines,
          maxLines:
              widget.numLines == 1 && widget.obscureText ? 1 : widget.numLines,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction ??
              (widget.numLines > 1
                  ? TextInputAction.newline
                  : TextInputAction.done),
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          inputFormatters: formatters,
          onChanged: widget.controller != null ? widget.onChanged : null,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
