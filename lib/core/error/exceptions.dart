class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class InvalidOtpException implements Exception {
  final String message;
  InvalidOtpException(this.message);
}

class NetworkException implements Exception {
  final String message = "No internet connection or network issue.";
}
