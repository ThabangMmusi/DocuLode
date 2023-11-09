import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user/app_user.dart';

abstract class BaseUserRepository {
  Stream<AppUser> getUser(User authUser);
}
