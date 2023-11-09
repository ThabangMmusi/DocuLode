import '../../_utils/logger.dart';
import '../../models/app_user/app_user.dart';
import '../commands.dart';

class SignInWithTokenCommand extends BaseAppCommand {
  Future<void> run(String url) async {
    String? idToken = Uri.parse(url).queryParameters["id_token"];
    String? refreshToken = Uri.parse(url).queryParameters["refresh_token"];

    firebase.seCurrentUser =
        AppUser(token: idToken, refreshToken: refreshToken);
    if (idToken != null) {
      if (await firebase.signInWithMicrosoft()) {
        log("Sign in was Successfully");
      } else {
        log("Sign in was Unsuccessfully");
      }
    } else {
      log("Sign in was Unsuccessfully: token is null");
    }
  }
}
