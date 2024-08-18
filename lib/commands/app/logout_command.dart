import '../../_utils/logger.dart';
import '../../core/common/models/app_user/app_user.dart';
import '../commands.dart';

class SetCurrentUserCommand extends BaseAppCommand {
  Future<void> run() async {
    log("SetCurrentUserCommand...");
    // Update appController with new user. If user is null, this acts as a logout command.

    AppUser? user = firebase.currentUser;
    if (user != null) {
      appModel.currentUser = null;
      firebase.signOut();
      // log("User loaded from firebase: ${user.toJson()}");
    }

    appModel.save();
  }
}
