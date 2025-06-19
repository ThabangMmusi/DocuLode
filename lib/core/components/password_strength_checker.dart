import 'package:flutter/material.dart';

// --- Password Criterion Model ---
class PasswordCriterion {
  final String label;
  final bool Function(String)
      validator; // Function to check if criterion is met
  bool isMet;

  PasswordCriterion({
    required this.label,
    required this.validator,
    this.isMet = false,
  });
}

// --- PasswordStrengthChecker Widget ---
class PasswordStrengthChecker extends StatelessWidget {
  final String password;
  final int minLength;
  final Color metColor;
  final Color unmetColor;
  final Color errorColor;

  final List<PasswordCriterion> _criteria;

  PasswordStrengthChecker({
    super.key,
    required this.password,
    this.minLength = 8,
    this.metColor = Colors.green, // Color when criterion is met
    this.unmetColor = Colors.grey, // Color for unmet criteria text/icon
    this.errorColor = Colors.red, // Color for the main error message
  }) : _criteria = _generateCriteria(minLength) {
    // Update 'isMet' for each criterion based on the current password
    for (var criterion in _criteria) {
      criterion.isMet = criterion.validator(password);
    }
  }

  static List<PasswordCriterion> _generateCriteria(int minLength) {
    return [
      PasswordCriterion(
        label: 'Uppercase letter',
        validator: (p) => p.contains(RegExp(r'[A-Z]')),
      ),
      PasswordCriterion(
        label: 'Lowercase letter',
        validator: (p) => p.contains(RegExp(r'[a-z]')),
      ),
      PasswordCriterion(
        label: 'Number',
        validator: (p) => p.contains(RegExp(r'[0-9]')),
      ),
      PasswordCriterion(
        label: 'Special character (e.g. !?<>@#\$%)',
        validator: (p) => p.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      ),
      PasswordCriterion(
        label: '$minLength characters or more',
        validator: (p) => p.length >= minLength,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Use a dark theme for this widget if the parent context doesn't imply it
    final ThemeData effectiveTheme = Theme.of(context);
    final bool isDark = effectiveTheme.brightness == Brightness.dark;
    final Color defaultTextColor = isDark ? Colors.white70 : Colors.black54;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall error message (shown if min length not met, as in the image)

        // List of criteria
        ..._criteria.map((criterion) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                Icon(
                  criterion.isMet
                      ? Icons.check_circle // Filled circle with check
                      : Icons.circle_outlined, // Empty circle
                  color: criterion.isMet ? metColor : unmetColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  criterion.label,
                  style: TextStyle(
                    fontSize: 14,
                    // Text color can also change, or stay consistent
                    color: criterion.isMet
                        ? defaultTextColor.withOpacity(0.9)
                        : unmetColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
