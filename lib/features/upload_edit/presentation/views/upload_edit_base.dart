import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:its_shared/widgets/labeled_text_input.dart';

import '../../../../styles.dart';
import '../../../uploads/presentation/components/dl_button.dart';

const List<String> _docTypes = <String>[
  "Questions Paper",
  "Memo",
  "Notes",
];

class RoundedRectInputChip extends StatefulWidget {
  const RoundedRectInputChip(this.text,
      {this.onDeleted, this.onSelected, super.key});
  final String text;
  final ValueChanged<String>? onDeleted;
  final ValueChanged<String>? onSelected;
  @override
  State<RoundedRectInputChip> createState() => _RoundedRectInputChipState();
}

class _RoundedRectInputChipState extends State<RoundedRectInputChip> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(widget.text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      onDeleted: () => widget.onDeleted!(widget.text),
      selected: _selected,
      onSelected: (bool selected) {
        setState(() {
          _selected = selected;
        });
      },
    );
  }
}

class ModuleChip extends StatelessWidget {
  const ModuleChip(this.text, {required this.onDeleted, super.key});
  final String text;
  final ValueChanged<String> onDeleted;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    // return SizedBox(
    //   height: 32,
    //   child: InputChip(
    //     padding: EdgeInsets.symmetric(horizontal: Insets.sm, vertical: 1)
    //         .copyWith(right: 2),
    //     label: Text(text, style: TextStyles.body3),
    //     deleteIconBoxConstraints: BoxConstraints(maxHeight: 18, maxWidth: 18),
    //     labelPadding: EdgeInsets.zero,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(Insets.lg),
    //       side: const BorderSide(
    //         color: Colors.transparent,
    //         width: 1.0,
    //       ),
    //     ),
    //     onDeleted: () => onDeleted(text),
    //     // selected: _selected,
    //     // onSelected: (bool selected) {
    //     //   setState(() {
    //     //     _selected = selected;
    //     //   });
    //     // },
    //   ),
    // );

    return Container(
      margin: EdgeInsets.only(right: Insets.xs),
      padding: EdgeInsets.fromLTRB(Insets.sm, 1, 2, 1),
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        borderRadius: BorderRadius.circular(Insets.lg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: TextStyles.body3),
          HSpace.xs,
          DlIconButton(
            icon: Ionicons.close,
            size: 18,
            padding: EdgeInsets.zero,
            iconColor: colors.onSurface,
            onPressed: () => onDeleted(text),
          )
        ],
      ),
      // onDeleted: () => onDeleted(text),
      // selected: _selected,
      // onSelected: (bool selected) {
      //   setState(() {
      //     _selected = selected;
      //   });
      // },
    );
  }
}

class UploadEditBase extends StatelessWidget {
  const UploadEditBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadEditBloc, UploadEditState>(
      listener: (context, state) {
        if (state.status == UploadEditStatus.success) {
          return Navigator.of(context).pop();
        }
      },
      child: SizedBox(
        height: 425,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const _NameField(),
          VSpace.med,
          const SubTitle("Types"),
          Divider(
            height: Insets.lg - 1,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 5.0,
            runSpacing: 5,
            children: List<Widget>.generate(
              _docTypes.length,
              (int index) {
                return RoundedRectInputChip(
                  _docTypes[index],
                  // selected: selectedIndex == index,
                  // onSelected: (bool selected) {
                  //   // setState(() {
                  //   //   if (selectedIndex == index) {
                  //   //     selectedIndex = null;
                  //   //   } else {
                  //   //     selectedIndex = index;
                  //   //   }
                  //   // });
                  // },
                  // onDeleted: () {
                  //   // setState(() {
                  //   //   inputs = inputs - 1;
                  //   // });
                  // },
                );
              },
            ).toList(),
          ),
          VSpace.med,
          const SubTitle(
            "Modules",
            // trailing: SegmentedButton(
            //     segments: const [
            //       ButtonSegment(value: 1, label: Text("Semester 1")),
            //       ButtonSegment(value: 2, label: Text("Semester 1"))
            //     ],
            //     onSelectionChanged: (p0) {
            //       context
            //           .read<UploadEditBloc>()
            //           .add(UploadEditSemesterChanged(p0));
            //     },
            //     selected: context.watch<UploadEditBloc>().state.semester),
          ),
          Divider(
            height: Insets.lg - 1,
          ),

          // Wrap(
          //   alignment: WrapAlignment.center,
          //   spacing: 5.0,
          //   runSpacing: 5,
          //   children: List<Widget>.generate(
          //     _docTypes.length,
          //     (int index) {
          //       return RoundedRectInputChip(
          //         _docTypes[index],
          //         // selected: selectedIndex == index,
          //         // onSelected: (bool selected) {
          //         //   // setState(() {
          //         //   //   if (selectedIndex == index) {
          //         //   //     selectedIndex = null;
          //         //   //   } else {
          //         //   //     selectedIndex = index;
          //         //   //   }
          //         //   // });
          //         // },
          //         // onDeleted: () {
          //         //   // setState(() {
          //         //   //   inputs = inputs - 1;
          //         //   // });
          //         // },
          //       );
          //     },
          //   ).toList(),
          // ),
          const EditableChipFieldExample(),
          VSpace.med,
          // Divider(
          //   height: Insets.lg + Insets.xs - 1,
          // ),
          // const SubTitle("Modules"),
          // Divider(
          //   height: Insets.lg + Insets.xs - 1,
          // ),
          Row(
            children: [
              const Spacer(),
              DLFilledButton(
                'Upload',
                // iconToRight: true,
                icon: Ionicons.arrow_up_circle_outline,
                onPressed: () async {
                  // UploadFileCommand().run(files: pickedImage!);
                  // Trigger file upload event
                  // BlocProvider.of<UploadProgressBloc>(context)
                  //     .add(UploadFiles(pickedImage!));
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle(
    this.title, {
    this.trailing,
    super.key,
  });
  final String title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.body2,
        ),
        trailing ?? Container()
      ],
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    final state = context.watch<UploadEditBloc>().state;

    return LabeledTextInput(
      key: const Key('editTodoView_title_textFormField'),
      label: "Filename",
      text: state.name,
      maxLength: 50,
      suffix: Padding(
        padding: EdgeInsets.all(Insets.sm),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Insets.sm).copyWith(top: 2),
          decoration: BoxDecoration(
              color: colors.inverseSurface, borderRadius: Corners.lgBorder),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.ext.toUpperCase(),
                style: TextStyles.body3.copyWith(color: colors.surface),
              ),
            ],
          ),
        ),
      ),
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(50),
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      // ],
      onChanged: (value) {
        context.read<UploadEditBloc>().add(UploadEditNameChanged(value));
      },
    );
  }
}

const List<String> _pizzaToppings = <String>[
  'Olives',
  'Tomato',
  'Cheese',
  'Pepperoni',
  'Bacon',
  'Onion',
  'Jalapeno',
  'Mushrooms',
  'Pineapple',
];

class EditableChipFieldExample extends StatefulWidget {
  const EditableChipFieldExample({super.key});

  @override
  EditableChipFieldExampleState createState() {
    return EditableChipFieldExampleState();
  }
}

class EditableChipFieldExampleState extends State<EditableChipFieldExample> {
  final FocusNode _chipFocusNode = FocusNode();
  List<String> _toppings = <String>[_pizzaToppings.first];
  List<String> _suggestions = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChipsInput<String>(
          values: _toppings,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.local_pizza_rounded),
            hintText: 'Search for toppings',
          ),
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          chipBuilder: _chipBuilder,
          onTextChanged: _onSearchChanged,
        ),
        if (_suggestions.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return ToppingSuggestion(
                  _suggestions[index],
                  onTap: _selectSuggestion,
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results
          .where((String topping) => !_toppings.contains(topping))
          .toList();
    });
  }

  Widget _chipBuilder(BuildContext context, String topping) {
    return ModuleChip(
      topping,
      onDeleted: _onChipDeleted,
      // onSelected: _onChipTapped,
    );
  }

  void _selectSuggestion(String topping) {
    setState(() {
      _toppings.add(topping);
      _suggestions = <String>[];
    });
  }

  // void _onChipTapped(String topping) {}

  void _onChipDeleted(String topping) {
    setState(() {
      _toppings.remove(topping);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        log(text);
        if (_suggestions.isNotEmpty) {
          final topSuggestion = _suggestions.first;
          // _toppings = <String>[..._toppings, topSuggestion.trim()];
          _toppings.add(topSuggestion);
          _suggestions = <String>[];
        } else {
          // _toppings. = _toppings;
        }
      });
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _toppings = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _toppings = data;
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return _pizzaToppings.where((String topping) {
        return topping.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    // this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  // final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return LabeledTextInput(
      // minLines: 1,
      // maxLines: 3,
      numLines: 1,
      // textInputAction: TextInputAction.done,
      style: widget.style,
      // strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmit: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets = values.map((T v) => WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class ToppingSuggestion extends StatelessWidget {
  const ToppingSuggestion(this.topping, {super.key, this.onTap});

  final String topping;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(topping),
      leading: CircleAvatar(
        child: Text(
          topping[0].toUpperCase(),
        ),
      ),
      title: Text(topping),
      onTap: () => onTap?.call(topping),
    );
  }
}
