part of 'sign_in_form_content.dart';

class EmailStep extends StatelessWidget {
  final SignInState state;
  const EmailStep({required this.state, super.key});
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      final email = "realt.wail@gmail.com";
      context.read<SignInBloc>().add(EmailChanged(email));
    }
    final bool isSendingOtp =
        state.activeOperation == SignInOperation.sendingInitialOtp &&
            state.operationStatus == OperationStatus.inProgress;
    final bool canSubmit = state.isEmailReadyForOtpSend && !isSendingOtp;

    // Only show server errors in MessageContainer, validation errors will be shown inline
    String? displayError;
    if (state.operationStatus == OperationStatus.failure) {
      displayError = state.operationError;
    }

    return Column(
      key: const ValueKey('student_number_sub_view_content'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (displayError != null)
          Padding(
            padding: EdgeInsets.only(bottom: Insets.med),
            child: MessageContainer(
              message: displayError,
              type: MessageType.error,
            ),
          ),
        StyledTextInput(
          label: tEmail,
          initialValue: state.email,
          onChanged: (value) =>
              context.read<SignInBloc>().add(EmailChanged(value)),
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Ionicons.school_outline),
          autoFocus: true,
          hintText: 'Enter your email address',
          // errorText: state.emailError, // Show validation errors inline
          onSubmitted: (_) {
            if (canSubmit) {
              context.read<SignInBloc>().add(const RequestOtpForEmail());
            }
          },
        ),
        VSpace.xl,
        PrimaryBtn(
          label: tSendOTP.toUpperCase(),
          onPressed: canSubmit
              ? () => context.read<SignInBloc>().add(const RequestOtpForEmail())
              : null,
          isLoading: isSendingOtp,
        ),
      ],
    );
  }
}
