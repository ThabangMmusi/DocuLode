import '../../_utils/logger.dart';
import '../../core/data/models/src/app_user/app_user.dart';
import '../commands.dart';

class SetCurrentUserCommand extends BaseAppCommand {
  Future<void> run() async {
    log("SetCurrentUserCommand...");
    // Update appController with new user. If user is null, this acts as a logout command.
    AppUser? user = firebase.currentUser;
    if (user != null) {
      log("SetCurrentUserCommand... user not null");
      appModel.currentUser = user;
      log("User loaded from firebase: ${user.toJson()}");
    } else
    // If currentUser is null here, then we've either logged out, or auth failed.
    {
      log("SetCurrentUserCommand... user is null");
      appModel.reset();
    }
    appModel.save();
  }
}
