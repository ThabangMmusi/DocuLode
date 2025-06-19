# Error Handling Pattern Requirements

## State Management Pattern
1. **Operation Status vs Active Operation**
   - `operationStatus` should be used to indicate the general state (success/failure/inProgress)
   - `activeOperation` should be used to identify which specific operation failed
   - Never check `activeOperation` for status, only for identifying the operation type

2. **Error Handling Flow**
   - BLoC should:
     - Set `operationStatus` to `failure` for any error
     - Keep `activeOperation` unchanged to identify which operation failed
     - Set `operationError` with the error message
   - UI should:
     - Check `operationStatus` for failure state
     - Use `activeOperation` only to identify which operation failed
     - Display appropriate error message based on operation type

3. **Implementation Example**
```dart
// In BLoC
emit(state.copyWith(
  operationStatus: OperationStatus.failure,
  operationError: errorMessage,
  // Keep activeOperation unchanged
));

// In UI
if (state.operationStatus == OperationStatus.failure) {
  String? errorMessage = state.operationError;
  // Use activeOperation only to identify operation type
  if (state.activeOperation == SignInOperation.verifyingOtpCode) {
    // Handle OTP verification specific errors
  }
}
```

4. **Benefits**
   - Clearer separation of concerns
   - More predictable error handling
   - Easier to maintain and debug
   - Consistent error display across the app

5. **Common Pitfalls to Avoid**
   - Don't check `activeOperation` for status
   - Don't mix operation identification with status checking
   - Don't reset `activeOperation` on error
   - Don't use operation-specific error states

6. **Testing Requirements**
   - Test error handling for each operation type
   - Verify error messages are displayed correctly
   - Ensure error states are properly reset
   - Check error recovery flows 