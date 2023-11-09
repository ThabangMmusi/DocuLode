// import 'dart:async';

// import 'package:flutter/foundation.dart';

// import '../../models/app_user/app_user.dart';

// class AuthRepository {
//   final firebase_auth.FirebaseAuth _firebaseAuth;

//   AuthRepository({
//     firebase_auth.FirebaseAuth? firebaseAuth,
//   }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;


//   firebase_auth.UserCredential? credential;
//   Stream<AppUser> get user {
//     return _firebaseAuth.authStateChanges();
//   }
//   //  Stream<AppUser> get user {
//   //   return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) {
//   //     final user =
//   //         firebaseUser == null ? AppUser.empty : firebaseUser.toUser();
//   //     currentUser = user;
//   //     return user;
//   //   });
//   // }

//   Future<bool> signInWithMicrosoft() async {
//     final microsoftProvider = firebase_auth.MicrosoftAuthProvider();
//     try {
//       if (kIsWeb) {
//         await _firebaseAuth.signInWithPopup(microsoftProvider).then((value) {
//           credential = value;
//           print(credential!.credential!.accessToken);
//         });
//       } else {
//         credential = await _firebaseAuth.signInWithProvider(microsoftProvider);
//       }
//       return credential != null;
//     } on firebase_auth.FirebaseAuthMultiFactorException catch (e) {
//       throw Exception(e.message);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await Future.wait([
//         _firebaseAuth.signOut(),
//       ]);
//     } catch (_) {}
//   }
// }
