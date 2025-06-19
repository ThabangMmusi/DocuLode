import 'package:doculode/config/index.dart';
import 'package:doculode/core/common/settings/presentation/bloc/base_settings_bloc.dart';
import 'package:doculode/features/settings/presentation/widgets/course_settings.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/styled_text_input.dart';
import '../bloc/settings_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Bloc access in initState can be tricky if context isn't fully ready.
    // Defer to didChangeDependencies or use a flag.
  }

  void _initializeControllers(BuildContext context) {
    if (!_isInitialized) {
      final settingsState = context.read<SettingsBloc>().state;
      _firstNameController =
          TextEditingController(text: settingsState.firstNames);
      _lastNameController = TextEditingController(text: settingsState.lastName);
      _emailController = TextEditingController(text: settingsState.email);
      _isInitialized = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeControllers(context); // Initialize here
    // Update controllers if state changes externally, only if widget is still mounted
    // This can be complex if the BLoC updates frequently while text fields are focused.
    // Consider if text fields should only be updated if not focused, or use initialValue for TextFormField.
    if (mounted) {
      final settingsState =
          context.watch<SettingsBloc>().state; // Using watch for updates
      if (_firstNameController.text != settingsState.firstNames &&
          !FocusScope.of(context).hasFocus) {
        _firstNameController.text = settingsState.firstNames;
      }
      if (_lastNameController.text != settingsState.lastName &&
          !FocusScope.of(context).hasFocus) {
        _lastNameController.text = settingsState.lastName;
      }
      // Email is read-only, so it's safer to update
      if (_emailController.text != settingsState.email) {
        _emailController.text = settingsState.email;
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure controllers are initialized before build if not already
    // This is a fallback, didChangeDependencies should handle it.
    if (!_isInitialized) _initializeControllers(context);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          // Added for potentially long content
          padding: EdgeInsets.all(Insets.lg), // Overall padding for the view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionContainer(
                title: 'Personal info',
                subtitle: 'Update your photo and personal details here',
                content: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: StyledTextInput(
                                      controller: _firstNameController,
                                      label: 'First name',
                                    ),
                                  ),
                                  HSpace.med,
                                  Expanded(
                                    child: StyledTextInput(
                                      controller: _lastNameController,
                                      label: 'Last name',
                                    ),
                                  ),
                                ],
                              ),
                              VSpace.med,
                              StyledTextInput(
                                readOnly: true,
                                controller: _emailController,
                                label: 'Primary email',
                              ),
                            ],
                          ),
                        ),
                        HSpace.xl,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VSpace(Insets.xs +
                                1), // Minor adjustment for alignment
                            CircleAvatar(
                              radius: IconSizes.lg *
                                  1.5, // Use IconSizes for relative sizing
                              backgroundColor: colorScheme.primaryContainer,
                              child: Text(
                                state.firstNames.isNotEmpty
                                    ? state.firstNames[0].toUpperCase()
                                    : (state.lastName.isNotEmpty
                                        ? state.lastName[0].toUpperCase()
                                        : 'U'), // Fallback for avatar
                                style: textTheme.headlineLarge?.copyWith(
                                  // Use a large, themed text style
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            VSpace.sm,
                            Row(
                              children: [
                                TextBtn(
                                  'Change',
                                  isCompact: true,
                                  onPressed: () {
                                    // Implement change photo logic
                                  },
                                ),
                                if (state.imageUrl.isNotEmpty) ...[
                                  HSpace.xs, // Slightly less space
                                  IconBtn(
                                    Icons
                                        .delete_outline, // More standard delete icon
                                    isCompact: true,
                                    tooltip: "Remove photo",
                                    color: colorScheme
                                        .error, // Make delete icon red
                                    onPressed: () {
                                      // Implement remove photo logic
                                    },
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    VSpace.lg, // Add some space before potential save button
                    Align(
                      alignment: Alignment.centerRight,
                      child: PrimaryBtn(
                        label: "Save Changes",
                        onPressed: () {
                          // Dispatch event to save profile info
                          // context.read<SettingsBloc>().add(UpdateProfileInfo(...));
                        },
                      ),
                    )
                  ],
                ),
              ),
              VSpace.lg, // Space between sections
              const SectionContainer(
                title: 'Course info',
                subtitle: 'Update your course and modules details here',
                content: CourseSettings<SettingsBloc>(),
              ),
              VSpace.lg,
              SectionContainer(
                title: 'Account deletion',
                subtitle: 'This action is permanent and cannot be undone',
                subtitleColor: colorScheme.error, // Use themed error color
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.status == SettingsStatus.deleting)
                      StyledLoadSpinner.small(
                          valueColor:
                              colorScheme.error) // Error color for spinner
                    else
                      DeleteBtn(
                        // Uses themed DeleteBtn
                        label: 'Delete account',
                        onPressed: () =>
                            _showDeleteConfirmation(context, theme),
                      ),
                  ],
                ),
              ),
              VSpace.lg,
              SectionContainer(
                title: 'Sign out',
                subtitle: 'Sign out of your account on this device',
                subtitleColor: colorScheme.primary, // Use themed primary color
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.status == SettingsStatus.signingOut)
                      const StyledLoadSpinner() // Default spinner
                    else
                      SecondaryBtn(
                        // Uses themed SecondaryBtn
                        label: 'Sign out',
                        onPressed: () => context
                            .read<SettingsBloc>()
                            .add(SignOutRequested()),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, ThemeData theme) {
    // Pass theme
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // AlertDialog will use DialogTheme from AppTheme.dart
        title: const Text('Delete Account?'),
        content: const Text(
            'This action cannot be undone. All your data will be permanently deleted.'),
        actions: [
          TextButton(
            // Uses themed TextButton
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          // Using our themed DeleteBtn for consistency, or a styled FilledButton
          DeleteBtn(
            label: "Delete",
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<SettingsBloc>().add(SettingsAccountDelete());
            },
          ),
          // Alternative using FilledButton if DeleteBtn is too specific:
          // FilledButton(
          //   style: FilledButton.styleFrom(
          //     backgroundColor: theme.colorScheme.error,
          //     foregroundColor: theme.colorScheme.onError,
          //   ).merge(theme.filledButtonTheme.style), // Ensure it merges with global style if any
          //   onPressed: () {
          //     Navigator.of(dialogContext).pop();
          //     context.read<SettingsBloc>().add(SettingsAccountDelete());
          //   },
          //   child: const Text('Delete'),
          // ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? subtitleColor;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge, // Use themed style (was headlineSmall)
        ),
        VSpace.xs, // Add a small space
        Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            // Use themed style
            color: subtitleColor ??
                colorScheme.onSurfaceVariant, // Themed fallback color
          ),
        ),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final Color? subtitleColor;

  const SectionContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(
          bottom: Insets.xl), // Changed to bottom margin for separation
      padding: EdgeInsets.all(Insets.lg), // Adjusted padding
      decoration: BoxDecoration(
        color: colorScheme
            .surfaceContainerLowest, // Use a very subtle surface color from M3 palette
        // Or: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: Corners.lgBorder,
        border: Border.all(
          color: colorScheme.outlineVariant, // Use themed outline color
          width: Strokes.thin, // Use Strokes
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2, // Give more space to header if content is wide
            child: Padding(
              padding: EdgeInsets.only(
                  right: Insets.xl), // Add padding to separate from content
              child: SectionHeader(
                title: title,
                subtitle: subtitle,
                subtitleColor: subtitleColor,
              ),
            ),
          ),
          Expanded(
            flex: 3, // Give more space to content
            child: content,
          ),
        ],
      ),
    );
  }
}
