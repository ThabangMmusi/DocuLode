import 'package:flutter/material.dart';

class OverlayContent extends StatelessWidget {
  final String title;
  final String description;

  const OverlayContent({
    super.key,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(title,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center),
      const SizedBox(height: 20),
      Text(description,
          style: TextStyle(
              fontSize: 15, color: Color(0xFFC8E6C9).withOpacity(0.9)),
          textAlign: TextAlign.center),
    ]);
  }
}
