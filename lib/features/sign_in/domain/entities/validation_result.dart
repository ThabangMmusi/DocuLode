class ValidationResult {
  bool get isValid => errorMessage == null;
  final String? errorMessage;

  ValidationResult({this.errorMessage});
}
