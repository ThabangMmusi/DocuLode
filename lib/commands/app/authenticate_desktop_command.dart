import 'package:url_launcher/url_launcher.dart';

import '../../_utils/logger.dart';
import '../commands.dart';

//
class AuthenticateDesktopCommand extends BaseAppCommand {
  Future<void> run() async {
    log("AuthenticateDesktopCommand...");
    //get access token from web authenticate user;
    var accessToken = await firebase.getAccessToken();
    var refreshToken = firebase.getRefreshToken;
    if (accessToken != null) {
      var url = Uri(
        scheme: 'itsshared',
        path: 'auth',
        query: _encodeQueryParameters(<String, String>{
          'id_token': accessToken,
          if (refreshToken != null) 'refresh_token': refreshToken,
        }),
      );
      log(url.toString());
      // log(accessToken);

      if (!await launchUrl(url, webOnlyWindowName: '_self')) {
        log("Could not launch");
        throw Exception('Could not launch $url');
      }
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> openLoginTab() async {
    var _url = Uri.parse("http://localhost:23429/auth/web-auth");
    if (!await launchUrl(_url)) {
      log("Could not launch");
      throw Exception('Could not launch $_url');
    }
  }
}
