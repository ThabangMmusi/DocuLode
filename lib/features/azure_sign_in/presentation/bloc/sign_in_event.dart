import 'package:equatable/equatable.dart';

import 'sign_in_state.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object?> get props => [];
}

class FormFlowChanged extends SignInEvent {
  final SignInFlow targetFlow;
  const FormFlowChanged(this.targetFlow);
  @override
  List<Object?> get props => [targetFlow];
}

class MagicLinkVerificationSubmitted extends SignInEvent {
  const MagicLinkVerificationSubmitted();
}

class OtpVerifiedSuccess extends SignInEvent {
  const OtpVerifiedSuccess();
}

class SignInWithMicrosoft extends SignInEvent {
  const SignInWithMicrosoft();
}
