import 'package:doculode/core/constants/app_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; 


enum SignInFlow {
  email, 
  otpInput, 
  otpVerified, 
  
}

enum SignInOperation {
  none,
  sendingInitialOtp,
  verifyingOtpCode, 
  checkingUserStatus, 
  verifyingMagicLink, 
  resendingOtp,
}

class SignInState extends Equatable {
  final SignInFlow currentFlow;

  final String email;
  final String? emailError;

  final String otp;
  final String? otpInputError;

  final SignInOperation activeOperation;
  final OperationStatus operationStatus;
  final String? operationError;

  bool get isEmailReadyForOtpSend => email.isNotEmpty && emailError == null;
  bool get isOtpReadyForVerification =>
      otp.length == 6 && otpInputError == null; 

  const SignInState({
    this.currentFlow = SignInFlow.email,
    this.email = '',
    this.emailError,
    this.otp = '',
    this.otpInputError,
    this.activeOperation = SignInOperation.none,
    this.operationStatus = OperationStatus.idle,
    this.operationError,
  });

  SignInState copyWith({
    SignInFlow? currentFlow,
    String? email,
    ValueGetter<String?>? emailError,
    String? otp,
    ValueGetter<String?>? otpInputError,
    SignInOperation? activeOperation,
    OperationStatus? operationStatus,
    ValueGetter<String?>? operationError,
  }) {
    return SignInState(
      currentFlow: currentFlow ?? this.currentFlow,
      email: email ?? this.email,
      emailError: emailError != null ? emailError() : this.emailError,
      otp: otp ?? this.otp,
      otpInputError:
          otpInputError != null ? otpInputError() : this.otpInputError,
      activeOperation: activeOperation ?? this.activeOperation,
      operationStatus: operationStatus ?? this.operationStatus,
      operationError:
          operationError != null ? operationError() : this.operationError,
    );
  }

  @override
  List<Object?> get props => [
        currentFlow,
        email,
        emailError,
        otp,
        otpInputError,
        activeOperation,
        operationStatus,
        operationError,
      ];
}
