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

class RequestOtpForEmail extends SignInEvent {
  const RequestOtpForEmail();
}

class EmailChanged extends SignInEvent {
  final String email;
  const EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class OtpChanged extends SignInEvent {
  final String otp;
  const OtpChanged(this.otp);
  @override
  List<Object?> get props => [otp];
}

class OtpVerificationSubmitted extends SignInEvent {
  const OtpVerificationSubmitted();
}

class MagicLinkVerificationSubmitted extends SignInEvent {
  const MagicLinkVerificationSubmitted();
}

class ResendOtpRequested extends SignInEvent {
  const ResendOtpRequested();
}

class OtpVerifiedSuccess extends SignInEvent {
  const OtpVerifiedSuccess();
}
