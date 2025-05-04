import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../core/common/settings/settings.dart';
import '../../../../widgets/labeled_text_input.dart';
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

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsBloc>().state;
    _firstNameController = TextEditingController(text: state.names);
    _lastNameController = TextEditingController(text: state.lastName);
    _emailController = TextEditingController(text: state.email);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<SettingsBloc>().state;
    _firstNameController.text = state.names;
    _lastNameController.text = state.lastName;
    _emailController.text = state.email;
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
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
                                  child: LabeledTextInput(
                                    controller: _firstNameController,
                                    label: 'First name',
                                  ),
                                ),
                                HSpace.med,
                                Expanded(
                                  child: LabeledTextInput(
                                    controller: _lastNameController,
                                    label: 'Last name',
                                  ),
                                ),
                              ],
                            ),
                            VSpace.med,
                            LabeledTextInput(
                              readOnly: true,
                              controller: _emailController,
                              label: 'Primary email',
                            ),
                          ],
                        ),
                      ),
                      HSpace.xl,
                      Column(
                        children: [
                          VSpace(Insets.xs + 1),
                          CircleAvatar(
                            radius: 52,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              state.names.isNotEmpty
                                  ? state.names[0].toUpperCase()
                                  : 'T',
                              style: TextStyles.h1.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          VSpace(Insets.sm - 2),
                          Row(
                            children: [
                              TextBtn(
                                'Change',
                                isCompact: true,
                                style: TextStyles.body4,
                                onPressed: () {},
                              ),
                              if (state.imageUrl.isNotEmpty) ...[
                                HSpace.sm,
                                IconBtn(Icons.delete_outline_sharp,
                                    padding: EdgeInsets.all(Insets.sm - 2),
                                    compact: true,
                                    onPressed: () {}),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SectionContainer(
              title: 'Course info',
              subtitle: 'Update your course and modules details here',
              content: CourseSettings<SettingsBloc>(),
            ),
            SectionContainer(
              title: 'Account deletion',
              subtitle: 'This action is permanent and cannot be undone',
              subtitleColor: Theme.of(context).colorScheme.error,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.status == SettingsStatus.deleting)
                    const StyledLoadSpinner()
                  else
                    DeleteBtn(
                      label: 'Delete account',
                      onPressed: () => _showDeleteConfirmation(context),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
            'This action cannot be undone. All your data will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<SettingsBloc>().add(SettingsAccountDelete());
            },
            child: const Text('Delete'),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.h3,
        ),
        Text(
          subtitle,
          style: TextStyles.body2.copyWith(
            color:
                subtitleColor ?? Theme.of(context).colorScheme.onInverseSurface,
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
    return Container(
      margin: EdgeInsets.only(top: Insets.lg), // Add top margin
      padding: EdgeInsets.all(Insets.xl),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        borderRadius: Corners.lgBorder,
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SectionHeader(
              title: title,
              subtitle: subtitle,
              subtitleColor: subtitleColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: content,
          ),
        ],
      ),
    );
  }
}
