import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AuthOptionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isGoogle;

  const AuthOptionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isGoogle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon:
            isGoogle ? const Icon(Ionicons.logo_google) : Icon(icon, size: 22),
        label: Text(label),
        onPressed: onPressed,
        style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 22.0))),
      ),
    );
  }
}
