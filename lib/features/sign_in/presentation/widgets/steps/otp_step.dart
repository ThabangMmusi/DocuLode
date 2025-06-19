part of 'sign_in_form_content.dart';

class OtpStep extends StatelessWidget {
  final SignInState state;
  const OtpStep({required this.state, super.key});
  @override
  Widget build(BuildContext context) {
    final bool isVerifyingOtp =
        state.activeOperation == SignInOperation.verifyingOtpCode &&
            state.operationStatus == OperationStatus.inProgress;
    final bool isVerifyingMagicLink =
        state.activeOperation == SignInOperation.verifyingMagicLink &&
            state.operationStatus == OperationStatus.inProgress;
    final bool isResendingOtp =
        state.activeOperation == SignInOperation.resendingOtp &&
            state.operationStatus == OperationStatus.inProgress;
    final bool isAnyOtpOperationInProgress =
        isVerifyingOtp || isResendingOtp || isVerifyingMagicLink;

    // Show server errors in MessageContainer
    String? errorMessage;
    if (state.activeOperation == SignInOperation.verifyingOtpCode &&
        state.operationStatus == OperationStatus.failure) {
      errorMessage = state.operationError;
      // Add specific handling for token expired error
      if (errorMessage?.contains('Token has expired') == true) {
        errorMessage = 'OTP has expired. Please request a new one.';
      }
    }
     if (state.activeOperation == SignInOperation.verifyingMagicLink &&
        state.operationStatus == OperationStatus.failure) {
      errorMessage = state.operationError;
    }

    return AbsorbPointer(
      absorbing: isAnyOtpOperationInProgress,
      child: Column(
        key: const ValueKey('otp_verification_sub_view_content'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state.email.isNotEmpty) ...[
            TextWithLink(
                leftText: tWeSentOtpLinkTo,
                rightText: state.email,
                textAlign: TextAlign.center),
                TextWithLink(
                leftText: "You can use link, if you opened the verification email from ",
                rightText: "this device",
                textAlign: TextAlign.center),
            VSpace.lg,
          ],
          Stack(alignment: Alignment.center, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isVerifyingMagicLink)
                  Padding(
                    padding: EdgeInsets.only(bottom: Insets.med),
                    child: MessageContainer.info(
                       "Verifying magic link"
                    ),
                  ),
                if (errorMessage != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: Insets.med),
                    child: MessageContainer(
                      message: errorMessage,
                      type: MessageType.error,
                    ),
                  ),
                VSpace.sm,
                Opacity(
                  opacity: isAnyOtpOperationInProgress ? 0.4 : 1.0,
                  child: IgnorePointer(
                    ignoring: isAnyOtpOperationInProgress,
                    child: OtpInputWidget(
                      otpLength: 6,
                      initialValue: state.otp,
                      autofocusOnFirstField: true,
                      shouldUnfocus: isVerifyingMagicLink,
                      onChanged: (otp) {
                        if (!isVerifyingOtp) {
                          context.read<SignInBloc>().add(OtpChanged(otp));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            // if (isVerifyingOtp || isVerifyingMagicLink)
            //   Positioned.fill(
            //       child: Container(
            //           color: Theme.of(context)
            //               .scaffoldBackgroundColor
            //               .withValues(alpha: 0.7),
            //           child: Center(child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               StyledLoadSpinner.small(),
            //               VSpace.sm,
            //               Text(isVerifyingMagicLink?"Verifying magic link":"Verifying OTP")
            //             ],
            //           )))),
          ]),
          // VSpace.med,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ResendOtpTimer(isLoading: isResendingOtp),
            ],
          ),
          VSpace.med,
          PrimaryBtn(
            label: tVerifyOTP.toUpperCase(),
            onPressed: state.isOtpReadyForVerification
                ? () =>
                    context.read<SignInBloc>().add(const RequestOtpForEmail())
                : null,
            isLoading: isAnyOtpOperationInProgress,
          ),
          VSpace.xl,
          SecondaryBtn(
            label: tChangeEmail,
            icon: Ionicons.arrow_back_outline,
            onPressed: isAnyOtpOperationInProgress
                ? null
                : () => context
                    .read<SignInBloc>()
                    .add(FormFlowChanged(SignInFlow.email)),
          ),
        ],
      ),
    );
  }
}

class _ResendOtpTimer extends StatefulWidget {
  final bool isLoading;
  const _ResendOtpTimer({this.isLoading = false});
  @override
  State<_ResendOtpTimer> createState() => _ResendOtpTimerState();
}

class _ResendOtpTimerState extends State<_ResendOtpTimer> {
  static const int _resendCoolDownSeconds = 180;
  int _secondsRemaining = _resendCoolDownSeconds;
  bool _isTimerActive = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant _ResendOtpTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading && !widget.isLoading && !_isTimerActive) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isTimerActive && _timer?.isActive == true) _timer!.cancel();
    _secondsRemaining = _resendCoolDownSeconds;
    _isTimerActive = true;
    if (mounted) setState(() {});
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _isTimerActive = false;
        timer.cancel();
        if (mounted) setState(() {});
      }
    });
  }

  String _getFormattedTime() {
    int m = _secondsRemaining ~/ 60;
    int s = _secondsRemaining % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  void _onResendOtp() {
    if (!widget.isLoading && !_isTimerActive) {
      context.read<SignInBloc>().add(const ResendOtpRequested());
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final bool canTapToResend = !_isTimerActive && !widget.isLoading;
    Widget content;
    TextStyle baseStyle = textTheme.bodyMedium ?? const TextStyle();
    if (widget.isLoading) {
      content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your spinner widget if needed
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text("Resending OTP...",
                style: baseStyle.copyWith(color: colorScheme.onSurfaceVariant)),
          ]);
    } else if (_isTimerActive) {
      content = RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: baseStyle.copyWith(color: colorScheme.onSurfaceVariant),
              children: [
                TextSpan(text: 'Resend OTP again in '),
                TextSpan(
                    text: _getFormattedTime(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface)),
              ]));
    } else {
      content = Text("Resend OTP",
          style: baseStyle.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme.primary));
    }
    return InkWell(
        onTap: canTapToResend ? _onResendOtp : null,
        borderRadius: Corners.smBorder,
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Insets.sm, horizontal: Insets.xs),
            child: Center(child: content)));
  }
}
