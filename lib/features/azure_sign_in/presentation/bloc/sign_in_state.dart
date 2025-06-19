import 'package:doculode/core/constants/app_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; 


enum SignInFlow {
  email, browserSignIn, otpVerified, 
}

enum SignInOperation {
  none,
  verifyingMagicLink, 
  microsoftSignIn,
}

class SignInState extends Equatable {
  final SignInFlow currentFlow;
  final SignInOperation activeOperation;
  final OperationStatus operationStatus;
  final String? operationError;

  const SignInState({
    this.currentFlow = SignInFlow.email,
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
      activeOperation: activeOperation ?? this.activeOperation,
      operationStatus: operationStatus ?? this.operationStatus,
      operationError:
          operationError != null ? operationError() : this.operationError,
    );
  }

  @override
  List<Object?> get props => [
        currentFlow,
        activeOperation,
        operationStatus,
        operationError,
      ];
}
