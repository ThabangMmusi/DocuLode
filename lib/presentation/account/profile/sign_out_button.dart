import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({
    super.key,
  });

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => setState(() => _hovered = value),
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(kPaddingHalf),
      onTap: () {
        // Signing out the user
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
      child: Container(
        padding: const EdgeInsets.all(kPaddingHalf),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kPaddingHalf),
            color: _hovered ? tPrimaryColor.withAlpha(100) : tWhiteColor),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sign out",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Icon(Ionicons.log_out_outline)
          ],
        ),
      ),
    );
  }
}
