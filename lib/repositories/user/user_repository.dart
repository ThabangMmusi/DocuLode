import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user/app_user.dart';
import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;
  Stream<AppUser> currentUser = const Stream.empty();
  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<AppUser> getUser(User authUser) {
    print("Getting user from firestore 2");
    currentUser = _firebaseFirestore
        .collection("users")
        .doc(authUser.uid)
        .snapshots()
        .map((snap) => authUser.toUser(AppUser.fromJson(snap.data()!)));

    return currentUser;
  }
}

extension on User {
  AppUser toUser(AppUser currentUser) {
    return AppUser(
      uid: uid,
      names: currentUser.names,
      surname: currentUser.surname,
      classId: currentUser.classId,
      type: currentUser.type,
    );
  }
}
