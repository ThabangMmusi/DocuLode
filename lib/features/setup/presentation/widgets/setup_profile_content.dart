import 'package:doculode/config/index.dart';
import 'package:doculode/core/common/settings/presentation/bloc/base_settings_bloc.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/core/constants/app_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setup_bloc.dart';

class SetupProfileContent extends StatelessWidget {
  const SetupProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, BaseSettingsState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(0, -0.08), end: Offset.zero)
                        .animate(animation),
                child: child,
              ),
            );
          },
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: _buildEmailFormWrapper(context, state)),
        );
      },
    );
  }

  Widget _buildEmailFormWrapper(BuildContext context, BaseSettingsState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AuthHeader(
            headerText: "tContinueWithEmailTitle",
            subHeaderText: tContinueWithEmail),
        TextFormField(
          key: ValueKey("firstName"),
          initialValue: state.firstNames,
          decoration: InputDecoration(
            hintText: 'First Name',
            prefixIcon: const Icon(Icons.person_outline),
            errorText:
                state.firstNamesError == "" ? null : state.firstNamesError,
          ),
          onChanged: (value) =>
              context.read<SetupBloc>().add(FirstNameChanged(value)),
        ),
        const SizedBox(height: 18),
        TextFormField(
          key: ValueKey("lastName"),
          initialValue: state.lastName,
          decoration: InputDecoration(
            hintText: 'Last Name',
            prefixIcon: const Icon(Icons.person_outline),
            errorText: state.lastNameError == "" ? null : state.lastNameError,
          ),
          onChanged: (value) =>
              context.read<SetupBloc>().add(LastNameChanged(value)),
        ),
        VSpace(Insets.lg - 1),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: state.isNamesValid
                ? () => context.read<SetupBloc>().add(SetUpSwitchToAcademics())
                : null,
            child: Text(tContinue.toUpperCase()),
          ),
        ),
      ],
    );
  }
}
