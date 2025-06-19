import 'package:doculode/config/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputWidget extends StatefulWidget {
  final int otpLength;
  final ValueChanged<String> onChanged;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final double fieldWidth;
  final double fieldHeight;
  final MainAxisAlignment mainAxisAlignment;
  final String? initialValue;
  final bool autofocusOnFirstField;
  final bool shouldUnfocus;

  const OtpInputWidget({
    super.key,
    required this.otpLength,
    required this.onChanged,
    this.textStyle,
    this.inputDecoration,
    this.fieldWidth = 48.0,
    this.fieldHeight = 48.0,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.initialValue,
    this.autofocusOnFirstField = false,
    this.shouldUnfocus = false,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _textControllers;
  late final List<String> _otpValues;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.otpLength, (_) => FocusNode());
    _textControllers = List.generate(widget.otpLength, (_) => TextEditingController());
    _otpValues = List.filled(widget.otpLength, '');
    _populateInitialValue();
  }

  void _populateInitialValue() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      final len = widget.initialValue!.length < widget.otpLength
          ? widget.initialValue!.length
          : widget.otpLength;
      for (int i = 0; i < len; i++) {
        _otpValues[i] = widget.initialValue![i];
        _textControllers[i].text = widget.initialValue![i];
      }
    }
  }

  @override
  void didUpdateWidget(covariant OtpInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.otpLength != oldWidget.otpLength) {
      _disposeControllersAndNodes();
      _focusNodes = List.generate(widget.otpLength, (_) => FocusNode());
      _textControllers = List.generate(widget.otpLength, (_) => TextEditingController());
      _otpValues = List.filled(widget.otpLength, '');
      _populateInitialValue();
    } else if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _otpValues.join()) {
      for (int i = 0; i < widget.otpLength; i++) {
        _textControllers[i].clear();
        _otpValues[i] = '';
      }
      _populateInitialValue();
      _triggerOtpChange();
    } else if (widget.shouldUnfocus && !oldWidget.shouldUnfocus) {
      _unfocusAllFields();
    }
  }

  void _disposeControllersAndNodes() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
  }

  @override
  void dispose() {
    _disposeControllersAndNodes();
    super.dispose();
  }

  void _handlePaste(int index) async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final pastedText = clipboardData?.text ?? '';

    if (pastedText.isNotEmpty) {
      final cleanPastedText = pastedText.replaceAll(RegExp(r'[^0-9]'), '');

      if (cleanPastedText.isNotEmpty && mounted) {
        int currentPastedCharIndex = 0;
        for (int i = index; i < widget.otpLength; i++) {
          if (currentPastedCharIndex < cleanPastedText.length) {
            final char = cleanPastedText[currentPastedCharIndex];
            _otpValues[i] = char;
            _textControllers[i].text = char;
            currentPastedCharIndex++;
          } else {
            _otpValues[i] = '';
            _textControllers[i].clear();
          }
        }

        int nextFocusIndex = index + currentPastedCharIndex;
        if (nextFocusIndex < widget.otpLength) {
          FocusScope.of(context).requestFocus(_focusNodes[nextFocusIndex]);
        } else {
          _focusNodes[widget.otpLength - 1].unfocus();
        }

        _triggerOtpChange();
      }
    }
  }

  void _handleFieldChange(String value, int index) {
    if (value.isNotEmpty) {
      _otpValues[index] = value;
      if (index < widget.otpLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
        _checkCompletion();
      }
    } else {
      _otpValues[index] = '';
    }
    _triggerOtpChange();
  }

  void _handleBackspace(int index) {
    if (_textControllers[index].text.isNotEmpty) {
      _textControllers[index].clear();
      _otpValues[index] = '';
    } else if (index > 0) {
      _textControllers[index - 1].clear();
      _otpValues[index - 1] = '';
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    _triggerOtpChange();
  }

  void _triggerOtpChange() {
    widget.onChanged(_otpValues.join());
  }

  void _checkCompletion() {
    if (_otpValues.join().length == widget.otpLength &&
        _otpValues.every((val) => val.isNotEmpty)) {
      _unfocusAllFields();
    }
  }

  void _unfocusAllFields() {
    for (var node in _focusNodes) {
      node.unfocus();
    }
  }

  InputDecoration _getBaseInputDecoration() {
    return widget.inputDecoration ?? const InputDecoration();
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // Local focus node for RawKeyboardListener
        onKey: (RawKeyEvent event) {
          if (event.runtimeType == RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (_textControllers[index].text.isEmpty && index > 0) {
              _handleBackspace(index);
            } else if (_textControllers[index].text.isNotEmpty) {
              _textControllers[index].clear();
              _otpValues[index] = '';
              _triggerOtpChange();
            }
          }
        },
        child: TextField(
          controller: _textControllers[index],
          focusNode: _focusNodes[index],
          autofocus: index == 0 && widget.autofocusOnFirstField,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: widget.textStyle ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar.buttonItems(
              buttonItems: [
                ContextMenuButtonItem(
                  onPressed: () {
                    editableTextState.hideToolbar();
                    _handlePaste(index);
                  },
                  label: 'Paste OTP',
                ),
              ],
              anchors: editableTextState.contextMenuAnchors,
            );
          },
          decoration: _getBaseInputDecoration().copyWith(counterText: ""),
          onChanged: (value) => _handleFieldChange(value, index),
          onSubmitted: (_) => _checkCompletion(),
          textInputAction: (index == widget.otpLength - 1)
              ? TextInputAction.done
              : TextInputAction.next,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: List.generate(
        widget.otpLength,
        (index) {
          Widget field = _buildOtpField(index);

          if (index < widget.otpLength - 1) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [field, HSpace.sm],
            );
          }
          return field;
        },
      ),
    );
  }
}
