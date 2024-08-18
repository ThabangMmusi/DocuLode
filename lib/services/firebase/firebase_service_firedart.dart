import 'package:file_selector/file_selector.dart';
import 'package:its_shared/features/setup/data/models/module_model/module_model.dart';

import '../../core/core.dart';
import '../../core/common/models/app_user/app_user.dart';
import '../../core/common/models/course_model.dart';
import '../../features/setup/data/models/course_model/course_model.dart';
import 'firebase_rest_api.dart';
import 'firebase_service.dart';

class DartFirebaseService extends FirebaseService {
  DartFirebaseService();

  FirebaseRestApi get firebase => FirebaseRestApi.instance;

  // DocumentReference get userDoc => firestore.document(userPath.join("/"));

  @override
  Future<void> init() async {
    // final prefsStore = await PreferencesStore.create();
    // FirebaseRestApi.initialize();
  }

  @override
  Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
      {required String documentId, bool addUserPath = true}) {
    // TODO: implement addDoc
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDoc(List<String> keys) {
    // TODO: implement deleteDoc
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> getCollection(List<String> keys) {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getDoc(List<String> keys) {
    // TODO: implement getDoc
    throw UnimplementedError();
  }

  @override
  // TODO: implement isSignedIn
  bool get isSignedIn => throw UnimplementedError();

  @override
  Future<void> updateDoc(List<String> keys, Map<String, dynamic> json) {
    // TODO: implement updateDoc
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithMicrosoft([bool reauthenticate = false]) async {
    if (currentUser!.token != null) {
      ///for reauthenticate when program start
      ///will be saved along with the user;
      var accessToken = currentUser!.token;
      var refreshToken = currentUser!.refreshToken!;
      //try reauthenticate with the existing access token
//       FirebaseAuth.initialize( FirebaseConfig().apiKey, VolatileStore());
// await FirebaseAuth.instance.;
// var user = await FirebaseAuth.instance.getUser();
      if (await firebase.signInWithToken(accessToken!) == null) {
        accessToken = await firebase.reauthenticate(refreshToken);
      }

      ///GET USER DATA
      /// TODO: HANDLE EMPTY USER DATA -DOUBT THEY WILL BE ANY
      try {
        Map<String, dynamic>? newUser = await firebase.getCurrentUserData();
        seCurrentUser = AppUser.fromJson(newUser!)
            .copyWith(token: accessToken, refreshToken: refreshToken);
      } on Exception catch (e) {
        print(e);
      }
      userCourse = await getCourseDetails();
      if (!reauthenticate) {
        userChange();
      }
    }
    return super.signInWithMicrosoft();
  }

  ///////////////////////////////////////////////////
  //  Course Details
  //////////////////////////////////////////////////
  @override
  Future<CourseDetailsModel?> getCourseDetails() async {
    try {
      var classID = currentUser!.classId;
      var courseMap = await firebase.getDoc("courses/$classID");
      courseMap!["id"] = classID;
      return CourseDetailsModel.fromJson(courseMap);
    } catch (e) {
      print("courses from firebase: $e");
    }
    return null;
  }

  @override
  Future<List<CourseModel>> getAllCourses() async {
    return [];
  }

  @override
  Future<List<ModuleModel>> getSortedModules({
    required int maxLevel,
    required String courseId,
  }) async {
    return [];
  }

  /// //////////////////////////////
  // /// Auth
  // @override
  // Future<AppUser?> signIn({required String? accessToken}) async {
  //   User? user;
  //   try {
  //     if (createAccount) {
  //       user = await fireauth.signUp(email, password);
  //     } else {
  //       user = await fireauth.signIn(email, password);
  //     }
  //     _isSignedIn = true;
  //     return AppUser(email: user.email ?? "", fireId: user.id);
  //     // ignore: empty_catches
  //   } catch (e) {}
  //   return null;
  // }

  @override
  Future<void> signOut() async {
    super.signOut();
  }

  // @override
  // bool get isSignedIn => _isSignedIn;

  // /// ///////////////////////////////
  // /// CRUD
  // @override
  // Future<Map<String, dynamic>?> getDoc(List<String> keys) async {
  //   // print("getDocData: ${keys.toString()}");
  //   try {
  //     Document? d = (await _getDoc(keys)?.get());
  //     if (d != null) return d.map..['documentId'] = d.id;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return null;
  // }

  // @override
  // Future<List<Map<String, dynamic>>?> getCollection(List<String> keys) async {
  //   // print("getDocStream: ${keys.toString()}");
  //   Page<Document>? docs = (await _getCollection(keys)?.get());
  //   if (docs != null) {
  //     for (final d in docs) {
  //       d.map['documentId'] = d.id;
  //     }
  //   }
  //   return docs?.map((d) => d.map).toList();
  // }

  // @override
  // Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
  //     {String? documentId, bool addUserPath = true}) async {
  //   if (documentId != null) {
  //     keys.add(documentId);
  //     //safePrint("Add Doc ${getPathFromKeys(keys)}");
  //     await firestore.document(getPathFromKeys(keys, addUserPath: addUserPath)).update(json);
  //     //safePrint("Add Doc Complete");
  //     return documentId;
  //   }
  //   CollectionReference ref = firestore.collection(getPathFromKeys(keys, addUserPath: addUserPath));
  //   final doc = await ref.add(json);
  //   return (doc).id;
  // }

  // @override
  // Future<void> deleteDoc(List<String> keys) async {
  //   await firestore.document(getPathFromKeys(keys)).delete().catchError((Object e) {
  //     print(e);
  //   });
  // }

  // @override
  // Future<void> updateDoc(List<String> keys, Map<String, dynamic> json, [bool update = false]) async {
  //   await firestore.document(getPathFromKeys(keys)).update(json);
  // }

  // DocumentReference? _getDoc(List<String> keys) {
  //   if (checkKeysForNull(keys) == false) return null;
  //   DocumentReference docRef = firestore.document(getPathFromKeys(keys));
  //   //print("getDoc: " + docRef.path);
  //   return docRef;
  // }

  // CollectionReference? _getCollection(List<String> keys) {
  //   if (checkKeysForNull(keys) == false) return null;
  //   final colRef = firestore.collection(getPathFromKeys(keys));
  //   //print("Got path: " + colRef.path);
  //   return colRef;
  // }

  ///////////////////////////////////////////////////
  // Files - uploads
  //////////////////////////////////////////////////
  @override
  Stream<double> uploadFile(String name, [String? path, XFile? asset]) async* {
    // final path = "${currentUser?.uid}/uploads/$name";
    // final file = File(pickedFile.path);
    final user = currentUser;
    try {
      // String mimeType = pickedFile.asset!.mimeType!;
      // var metaData = UploadMetadata(contentType: mimeType);

      // final ref = fireStorage.ref().child(path);
      // var data = await pickedFile.asset?.readAsBytes();
      // UploadTask uploadTask = ref.putData(data!);
      // firebase.getDoc(docID)
      // firebase.uploadFile(pickedFile);
      // final snapshot = await uploadTask.whenComplete(() {});
      // final downloadLink = await snapshot.ref.getDownloadURL();
      final Map<String, dynamic> data2 = {
        "name": name,
        // "moduleId": pickedFile.moduleId,
        // "url": downloadLink,
        // "type": pickedFile.type,
        "classId": user!.classId,
        "likes": <String>[],
        "dislikes": <String>[],
        "downloads": <String>[],
      };
      // await firestore.collection("uploads").add(data2);
      // return downloadLink;
    } catch (e) {
      print('File Upload Error: $e');
      // return null;
    }
  }

  @override
  Future<FetchedRemoteDocs> getUserUploads() {
    // TODO: implement getUserUploads
    throw UnimplementedError();
  }
}
