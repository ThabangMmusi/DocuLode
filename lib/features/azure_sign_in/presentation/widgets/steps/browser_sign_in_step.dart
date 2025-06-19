part of 'sign_in_content.dart';

class BrowserSignInStep extends StatelessWidget {
  final SignInState state;
  const BrowserSignInStep({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    final bool isVerifyingMagicLink =
        state.activeOperation == SignInOperation.verifyingMagicLink &&
            state.operationStatus == OperationStatus.inProgress;
    String? errorMessage;
     if (state.activeOperation == SignInOperation.verifyingMagicLink &&
        state.operationStatus == OperationStatus.failure) {
      errorMessage = state.operationError;
    }
    return Center(
        child:isVerifyingMagicLink?Column(mainAxisSize: MainAxisSize.min,children: [            
            VSpace.lg,Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledLoadSpinner.small(),
              ],
            ),
            VSpace.med,
             Text(
            "Verifying...",
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          ])
          : Container(
      padding: EdgeInsets.all(Insets.med),
      margin: EdgeInsets.only(top: Insets.lg),
      decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: Corners.medBorder,
          border: Border.all(color: theme.colorScheme.tertiaryContainer)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Text(
            "A browser tab is opened for you\nto complete login",
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          VSpace.xl,
          TextWithLink(
            leftText: "Not seeing it?",
            rightText: "Try agin ",
            onTap: () =>
                context.read<SignInBloc>().add(const SignInWithMicrosoft()),
          )],
        
      ),
    ));
  }
}
