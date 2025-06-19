import 'package:flutter/material.dart';

class StyledDropDownTextfield<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final List<T> initialList;
  final T? value;
  final Function(T?) onSelectionChanged;
  final String? errorText;

  const StyledDropDownTextfield({
    super.key,
    required this.label,
    required this.hintText,
    required this.initialList,
    this.value,
    required this.onSelectionChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(hintText),
          items: initialList.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onSelectionChanged,
          decoration: InputDecoration(
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
