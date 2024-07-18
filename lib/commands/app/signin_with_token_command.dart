import 'package:flutter_bloc/flutter_bloc.dart';

import '../../_utils/logger.dart';
import '../../cubits/desktop_auth/desktop_auth_cubit.dart';
import '../../models/app_user/app_user.dart';
import '../commands.dart';

class SignInWithTokenCommand extends BaseAppCommand {
  void start(String url) async {
    mainContext.read<DesktopAuthCubit>().loginWithArgs(url);
  }

  Future<bool> finishUp(String url) async {
    String? idToken = Uri.parse(url).queryParameters["id_token"];
    String? refreshToken = Uri.parse(url).queryParameters["refresh_token"];

    firebase.seCurrentUser =
        AppUser(token: idToken, refreshToken: refreshToken);
    if (idToken != null) {
      if (await firebase.signInWithMicrosoft()) {
        log("Sign in was Successfully");
        return true;
      } else {
        log("Sign in was Unsuccessfully");
        return false;
      }
    } else {
      log("Sign in was Unsuccessfully: token is null");
      return false;
    }
  }
}
