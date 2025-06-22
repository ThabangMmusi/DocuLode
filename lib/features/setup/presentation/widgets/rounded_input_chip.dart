import 'package:flutter/material.dart';

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
      // showCheckmark: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      // onDeleted: () => widget.onDeleted!(widget.text),
      selected: _selected,
      onSelected: (bool selected) {
        setState(() {
          _selected = selected;
        });
      },
    );
  }
}
