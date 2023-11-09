class FirebaseConfig {
  final String apiKey = 'AIzaSyCPVt361KUEBiQp2Sl-md1g712wSiggvO4';
  final String appId = '1=830312586949=android=1812b7ede71c1c59269aac';
  final String messagingSenderId = '830312586949';
  final String projectId = 'spushare-2023';
  final String storageBucket = 'spushare-2023.appspot.com';

  //BASE URL API
  String get _projectPath =>
      "/projects/$projectId/databases/(default)/documents";

  String get firestoreApi => "https://firestore.googleapis.com/v1$_projectPath";

  // String parent(String userId) => "$_projectPath/notes/$userId/data/";

  /// To work on Notes List
  // String get USER_DATA_API =>
  //     "$_firestoreApi$/notes/${Utils.userId}/";

  /// Login Existing User with Token id/access
  String get loginWithAccessToken =>
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=$apiKey";

  /// Login Existing User with Refresh Token
  String get loginWithRefreshToken =>
      "https://securetoken.googleapis.com/v1/token?key=$apiKey";
}
