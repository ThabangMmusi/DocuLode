import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../_utils/logger.dart';
import '../../firebase_options.dart';
import '../../models/app_user/app_user.dart';
import '../../models/course_model.dart';
import 'firebase_service.dart';

class NativeFirebaseService extends FirebaseService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;

  DocumentReference get userDoc => firestore.doc(userPath.join("/"));

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)
        .catchError((Object e) {
      print("$e");
    });
    if (kIsWeb) {
      await auth.setPersistence(Persistence.LOCAL);
    }
    print("InitComplete");
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _isSignedIn = user != null;
    });
  }

  // Auth
  @override
  Future<bool> signInWithMicrosoft() async {
    UserCredential credential;

    try {
      if (kIsWeb) {
        credential = await auth.signInWithPopup(MicrosoftAuthProvider());
      } else {
        credential = await auth.signInWithProvider(MicrosoftAuthProvider());
      }
      var authUser = credential.user;
      if (authUser != null) {
        await firestore
            .collection("users")
            .doc(authUser.uid)
            .get()
            .then((value) {
          seCurrentUser =
              AppUser.fromJson(value.data()!).copyWith(uid: value.id);
        });
        userChange();
      }
      return authUser != null;
    } on FirebaseAuthMultiFactorException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await auth.currentUser!.getIdToken();
  }

  @override
  String? get getRefreshToken => auth.currentUser!.refreshToken;
  // Future<AppUser?> signIn({required String accessToken}) async {
  //   UserCredential userCreds;
  //   if (createAccount) {
  //     userCreds = await auth.createUserWithEmailAndPassword(email: email, password: password);
  //   } else {
  //     userCreds = await auth.signInWithEmailAndPassword(email: email, password: password);
  //   }
  //   User? user = userCreds.user;
  //   return user == null ? null : AppUser(email: user.email ?? "", fireId: user.uid);
  // }

  @override
  Future<void> signOut() async {
    await auth.signOut();
    super.signOut();
  }

  bool _isSignedIn = false;
  @override
  bool get isSignedIn => _isSignedIn;

  ///////////////////////////////////////////////////
  //  Course Details
  //////////////////////////////////////////////////
  @override
  Future<CourseModel?> getCourseDetails() async {
    try {
      return await firestore
          .collection("courses")
          .doc(currentUser!.uid)
          .get()
          .then((snapshot) => CourseModel.fromJson(snapshot.data()!));
    } catch (e) {
      print("courses from firebase: $e");
    }
    return null;
  }

  // Streams
  @override
  Stream<Map<String, dynamic>>? getDocStream(List<String> keys) {
    return null;

    // return _getDoc(keys)?.snapshots().map((doc) {
    //   final data = doc.data() ?? Map<String, dynamic>(){};
    //   return data..['documentId'] = doc.id;
    // });
  }

  @override
  Stream<List<Map<String, dynamic>>>? getListStream(List<String> keys) {
    return null;

    // return _getCollection(keys)?.snapshots().map(
    //   (QuerySnapshot snapshot) {
    //     return snapshot.docs.map((d) {
    //       final data = d.data();
    //       return data..['documentId'] = d.id;
    //     }).toList();
    //   },
    // );
  }

  // CRUD
  @override
  Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
      {String? documentId, bool addUserPath = true}) async {
    if (documentId != null) {
      keys.add(documentId);
      log("Add Doc ${getPathFromKeys(keys)}");
      await firestore
          .doc(getPathFromKeys(keys, addUserPath: addUserPath))
          .set(json);
      log("Add Doc Complete");
      return documentId;
    }
    CollectionReference ref =
        firestore.collection(getPathFromKeys(keys, addUserPath: addUserPath));
    final doc = await ref.add(json);
    return (doc).id;
  }

  @override
  Future<void> deleteDoc(List<String> keys) async =>
      await firestore.doc(getPathFromKeys(keys)).delete();

  @override
  Future<void> updateDoc(List<String> keys, Map<String, dynamic> json,
      [bool update = false]) async {
    await firestore.doc(getPathFromKeys(keys)).update(json);
  }

  @override
  Future<Map<String, dynamic>?> getDoc(List<String> keys) async {
    try {
      DocumentSnapshot? d = (await _getDoc(keys)?.get());
      if (d != null) {
        // return (d.data() ?? {})..['documentId'] = d.id;
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>?> getCollection(List<String> keys) async {
    return null;

    //print("getDocStream: ${keys.toString()}");
    // QuerySnapshot? snapshot = (await _getCollection(keys)?.get());
    // if (snapshot != null) {
    //   for (final d in snapshot.docs) {
    //     (d.data())['documentId'] = d.id;
    //   }
    // }
    // return snapshot?.docs.map((d) => (d.data())).toList();
  }

  DocumentReference? _getDoc(List<String> keys) {
    if (checkKeysForNull(keys) == false) return null;
    return firestore.doc(getPathFromKeys(keys));
  }

  CollectionReference? _getCollection(List<String> keys) {
    if (checkKeysForNull(keys) == false) return null;
    return firestore.collection(getPathFromKeys(keys));
  }

  @override
  Stream<AppUser?> get user {
    var authUsers = auth.authStateChanges();
    var user = auth.currentUser;
    var currentUser = firestore
        .collection("users")
        .doc(user!.uid)
        .snapshots()
        .map((snap) => user.toUser(AppUser.fromJson(snap.data()!)));
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
