import 'package:flutter/material.dart';

class StyledHorizontalNameList extends StatelessWidget {
  const StyledHorizontalNameList(
    this.names, {
    super.key,
    required this.style,
    required this.maxWidth,
  });

  final List<String> names;
  final TextStyle style;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    String displayedText = '';
    int remainingCount = 0;

    // Build the displayed names
    for (var name in names) {
      // Check if adding the name exceeds available width
      String potentialText =
          displayedText.isEmpty ? name : '$displayedText, $name';
      final textWidth = _calculateTextWidth(potentialText, style);

      if (textWidth <= maxWidth) {
        displayedText = potentialText;
      } else {
        remainingCount++;
      }
    }

    // Add "+ more" if there are remaining names
    if (remainingCount > 0) {
      displayedText += '... +$remainingCount';
    }

    return Text(
      displayedText,
      style: style,
    );
  }

  // Function to calculate text width
  double _calculateTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.size.width;
  }
}
