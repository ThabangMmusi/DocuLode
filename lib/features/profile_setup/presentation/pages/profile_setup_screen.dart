import 'package:doculode/config/index.dart';
import 'package:doculode/core/components/components.dart';
import 'package:doculode/features/profile_setup/presentation/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  @override
  void initState() {
    context.read<ProfileSetupBloc>().add(const GetUserName());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final double formPanelFraction = 0.55;
    final double overlayPanelFraction = 1.0 - formPanelFraction;
    final double formPanelWidth = screenSize.width * formPanelFraction;
    final double overlayPanelWidth = screenSize.width * overlayPanelFraction;
    const double cardBorderRadius = 0.0;

    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: AppShell(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: formPanelWidth,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: formPanelWidth * 0.08, vertical: Insets.xl),
                    child: const CompleteRegistrationForm()),
              ),
            ],
          ),
        ));
  }
}
