import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';

import '../../firebase_options.dart';
import '../../core/common/models/src/app_user/app_user.dart';
import 'firebase_service.dart';

class NativeFirebaseService extends FirebaseService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get fireStorage => FirebaseStorage.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;

  DocumentReference get userDoc => firestore.doc(userPath.join("/"));

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //     .catchError() {
    //   log("$e");
    //   return e;
    // });
    if (kIsWeb) {
      await auth.setPersistence(Persistence.LOCAL);
    }
    // //enable emulator
    // if (false) {
    // try {
    //   String host = 'localhost';
    //   // String host = '192.168.220.41';
    //   FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    //   await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    //   await FirebaseStorage.instance.useStorageEmulator(host, 9199);
    // } catch (e) {
    //   log(e.toString());
    // }
    // }
    // if (false) {
    //   await FirebaseAppCheck.instance.activate(
    //     // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    //     // argument for `webProvider`
    //     webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    //     // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    //     // your preferred provider. Choose from:
    //     // 1. Debug provider
    //     // 2. Safety Net provider
    //     // 3. Play Integrity provider
    //     androidProvider: AndroidProvider.debug,
    //     // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    //     // your preferred provider. Choose from:
    //     // 1. Debug provider
    //     // 2. Device Check provider
    //     // 3. App Attest provider
    //     // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    //     appleProvider: AppleProvider.appAttest,
    //   );
    // }
    log("InitComplete");
    auth.userChanges().listen((User? user) async {
      _isSignedIn = user != null;
      // await auth.signOut();
      await setNewUser(user?.uid);
    });
    // auth
    //     .getRedirectResult()
    //     .then((value) async => await setNewUser(value.user));
  }

  // Auth
  @override
  Future<bool> signInWithMicrosoft([bool reauthenticate = false]) async {
    AuthProvider provider = MicrosoftAuthProvider();

    try {
      if (!reauthenticate) {
        if (kIsWeb) {
          // auth
          //     .signInWithPopup(MicrosoftAuthProvider())
          //     .then((value) => value)
          //     .catchError((error) => print(error));z
          //TODO: USE POP UP AFTER FINDING A WAY TO PREVENT MULTIPLE POPUPS
          await auth.signInWithRedirect(provider);
          // await auth.signInWithPopup(provider).then((value) {
          //   log(value.toString());
          // });
        } else {
          // await auth.signInWithPopup(provider);
          await auth.signInWithProvider(provider);
        }
      } else {
        auth.currentUser!.getIdToken();
        streamUserChange();
      }
      return currentUser != null;
    } on FirebaseAuthMultiFactorException catch (e) {
      log("${e.message!}hhh");
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await auth.currentUser!.getIdToken();
  }

  @override
  String? get getRefreshToken => auth.currentUser!.refreshToken;
  // Future<AppUser?> signIn({required String accessToken}) async {
  //   UserCredential userCred;
  //   if (createAccount) {
  //     userCred = await auth.createUserWithEmailAndPassword(email: email, password: password);
  //   } else {
  //     userCred = await auth.signInWithEmailAndPassword(email: email, password: password);
  //   }
  //   User? user = userCred.user;
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
  //Todo: Delete course details
  // @override
  // Future<List<ModuleModel>> getSortedModules({
  //   required int maxLevel,
  //   required String courseId,
  // }) async {
  //   try {
  //     final course = await firestore
  //         .collection(FireIds.modules)
  //         .where(FireIds.courses, arrayContains: courseId)
  //         .where("level", isLessThanOrEqualTo: maxLevel)
  //         .get();
  //     return course.docs
  //         .map((doc) => ModuleModel.fromJson(doc.data()).copyWith(id: doc.id))
  //         .toList();
  //   } catch (e) {
  //     print("courses from firebase: $e");
  //   }
  //   return [];
  // }

///////////////////////////////////////////////////
  // DOCUMENTS
  //////////////////////////////////////////////////

  DocumentSnapshot? lastDocument;
  @override
  Future<FetchedRemoteDocs> getUserUploads() async {
    try {
      Query query = firestore
          .collection(FireIds.uploads)
          .where("uid", isEqualTo: userId)
          .orderBy("uploaded", descending: true)
          .limit(documentsPerPage);

      // if (lastDocument != null) {
      //   query = query.startAfterDocument(lastDocument!);
      // }

      final querySnapshot = await query.get();
      final documents = querySnapshot.docs;

      if (documents.isNotEmpty) {
        lastDocument = documents.last;
      }
      return FetchedRemoteDocs(
        docs: documents
            .map((doc) =>
                RemoteDocModel.fromJson(doc.data() as Map<String, dynamic>)
                    .copyWith(id: doc.id))
            .toList(),
        hasMore: documents.length == documentsPerPage,
      );
    } catch (e) {
      logError(e.toString());
      ServerException(e.toString());
      return FetchedRemoteDocs();
    }
  }

  @override
  Future<List<Map<String, dynamic>>?> getCollection(List<String> keys) async {
    try {
      log("getDocCollection: ${keys.toString()}");
      QuerySnapshot? snapshot = await _getCollection(keys)?.get();
      if (snapshot != null) {
        return snapshot.docs.map((d) {
          final data = d.data() as Map<String, dynamic>;
          data['id'] = d.id;
          return data;
        }).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Stream<AppUser?> get user {
    var user = auth.currentUser;
    var currentUser = firestore
        .collection("users")
        .doc(user!.uid)
        .snapshots()
        .map((snap) => AppUser.fromJson(snap.data()!));
    return currentUser;
  }

  @override
  Future<Map<String, dynamic>?> getDoc(List<String> keys) async {
    try {
      DocumentSnapshot? d = await _getDoc(keys)?.get();
      if (d != null && d.data() != null) {
        final data = d.data() as Map<String, dynamic>;
        data['id'] = d.id;
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
      {String? documentId, bool addUserPath = false}) async {
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
  Future<void> updateDoc(List<String> keys, Map<String, dynamic> json) async {
    await firestore.doc(getPathFromKeys(keys)).update(json);
  }

  ///////////////////////////////////////////////////
  // Files - uploads
  //////////////////////////////////////////////////
  @override
  Stream<double> uploadFile(String name, [String? path, XFile? asset]) async* {
    try {
      var data = await asset?.readAsBytes();
      final uploadTask = fireStorage.ref('uploads/${userId!}/$name').putData(
            data!,
            SettableMetadata(customMetadata: {'uid': userId!}),
          );
      await for (var event in uploadTask.snapshotEvents) {
        double progress = event.bytesTransferred / event.totalBytes;
        log("$name : $progress");
        yield progress;
        if (progress == 1.0) {
          uploadsStreamController.add(0);
        }
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    }
  }

  ///////////////////////////////////////////////////
  // native firebase helper
  //////////////////////////////////////////////////
  DocumentReference? _getDoc(List<String> keys) {
    if (checkKeysForNull(keys) == false) return null;
    return firestore.doc(getPathFromKeys(keys));
  }

  CollectionReference? _getCollection(List<String> keys) {
    if (checkKeysForNull(keys) == false) return null;
    return firestore.collection(getPathFromKeys(keys));
  }
}

// extension on User {
//   AppUser toUser(AppUser currentUser) {
//     return AppUser(
//       uid: uid,
//       names: currentUser.names,
//       surname: currentUser.surname,
//       classId: currentUser.classId,
//       type: currentUser.type,
//     );
//   }
// }
