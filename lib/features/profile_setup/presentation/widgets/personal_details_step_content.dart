import 'package:doculode/config/index.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../widgets/buttons/buttons.dart';
import '../bloc/profile_setup_bloc.dart';

class PersonalDetailsStepContent extends StatefulWidget {
  /* ... as defined before, but dispatches to ProfileSetupBloc ... */
  final ProfileSetupState state;
  const PersonalDetailsStepContent({super.key, required this.state});
  @override
  State<PersonalDetailsStepContent> createState() =>
      _PersonalDetailsStepContentState();
}

class _PersonalDetailsStepContentState
    extends State<PersonalDetailsStepContent> {
  late TextEditingController _firstNameController, _lastNameController;
  final FocusNode _firstNameFocusNode = FocusNode(),
      _lastNameFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.state.firstName);
    _lastNameController = TextEditingController(text: widget.state.lastName);
  }

  @override
  void didUpdateWidget(covariant PersonalDetailsStepContent oldWidget) {
    super.didUpdateWidget(
        oldWidget); /* Sync controllers with widget.state.firstName/LastName */
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  void _onFirstNameSubmitted(String v) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _lastNameFocusNode.canRequestFocus)
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
    });
  }

  void _onLastNameSubmitted(String v) {
    if (widget.state.isPersonalDetailsValid) _submit();
  }

  void _submit() {
    _firstNameFocusNode.unfocus();
    _lastNameFocusNode.unfocus();
    context
        .read<ProfileSetupBloc>()
        .add(const ChangeTheStep(ProfileSetupStep.academicFoundation));
  }

  @override
  Widget build(BuildContext context) {
    final ProfileSetupState state = widget.state;
    final bool canProceed = state.isPersonalDetailsValid;
    return Column(
        key: const ValueKey('personal_details_content_widget'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StyledTextInput(
              label: tProfileFirstNameLabel,
              controller: _firstNameController,
              focusNode: _firstNameFocusNode,
              onChanged: (val) =>
                  context.read<ProfileSetupBloc>().add(FirstNameChanged(val)),
              errorText: state.firstNameError,
              prefixIcon: const Icon(Ionicons.person_outline),
              textInputAction: TextInputAction.next,
              autoFocus: true,
              hintText: 'Enter your first name',
              onSubmitted: _onFirstNameSubmitted),
          VSpace.lg,
          StyledTextInput(
              label: tProfileLastNameLabel,
              controller: _lastNameController,
              focusNode: _lastNameFocusNode,
              onChanged: (val) =>
                  context.read<ProfileSetupBloc>().add(LastNameChanged(val)),
              errorText: state.lastNameError,
              prefixIcon: const Icon(Ionicons.person_outline),
              textInputAction: TextInputAction.done,
              hintText: 'Enter your last name',
              onSubmitted: _onLastNameSubmitted),
          VSpace.xxl,
          PrimaryBtn(
              label: tNext.toUpperCase(),
              onPressed: canProceed ? _submit : null),
        ]);
  }
}
