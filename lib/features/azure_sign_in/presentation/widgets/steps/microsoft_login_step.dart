part of 'sign_in_content.dart';

class MicrosoftLoginStep extends StatelessWidget {
  final SignInState state;
  const MicrosoftLoginStep({required this.state, super.key});
  @override
  Widget build(BuildContext context) {
   
    // Show server errors in MessageContainer
    String? errorMessage;
     if ((state.activeOperation == SignInOperation.microsoftSignIn||state.activeOperation == SignInOperation.verifyingMagicLink) &&
        state.operationStatus == OperationStatus.failure) {
      errorMessage = state.operationError;
    }

    return Column(
            key: const ValueKey('otp_verification_sub_view_content'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: Insets.med),
              //   child: TextWithLink(
              //   leftText: "Currently Supporting only\n",
              //   rightText: "Sol Plaatje University",
              //   textAlign: TextAlign.center),
              // ),
              if (errorMessage != null)
                Padding(
                  padding: EdgeInsets.only(bottom: Insets.med),
                  child: MessageContainer(
                    message: errorMessage,
                    type: MessageType.error,
                  ),
                ),
              VSpace.xxl,
             PrimaryBtn(
        label: tSignIn,
        icon: Ionicons.logo_microsoft,
        style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: Corners.fullBorder))
  ,
        onPressed: () => context.read<SignInBloc>().add(const SignInWithMicrosoft()),
        isLoading: state.activeOperation == SignInOperation.microsoftSignIn &&
            state.operationStatus == OperationStatus.inProgress,

      ),],
          );
  }
}
