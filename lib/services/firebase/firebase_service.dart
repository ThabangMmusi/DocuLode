// import 'dart:async';

// import 'package:file_selector/file_selector.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:html' as html;

// import '../../_utils/device_info.dart';
// import '../../_utils/logger.dart';
// import '../../core/data/models/models.dart';
// import '../../core/core.dart';
// import 'firebase_service_native.dart';
// import '../database_service.dart';

// // CollectionKeys
// class FireIds {
//   static const String users = "users";
//   static const String uploads = "uploads";
//   static const String course = "course";
//   static const String courses = "courses";
//   static const String modules = "modules";
//   static const String level = "level";
//   static const String more = "more";
//   static const String saves = "saves";
//   static const String profile = "profile";
//   static const String details = "details";
//   static const String increaseDownload = "increaseDownload";
// }

// // Returns the correct Firebase instance depending on platform
// class FirebaseFactory {
//   static bool _initComplete = false;

//   // Determine which platforms we can use the native sdk on
//   static bool get useNative =>
//       DeviceOS.isMobileOrWeb; // || UniversalPlatform.isMacOS;

//   static FirebaseService create() {
//     // FirebaseService service =
//     //     useNative ? NativeFirebaseService() : DartFirebaseService();
//     FirebaseService service = NativeFirebaseService();
//     if (_initComplete == false) {
//       _initComplete = true;
//       service.init();
//     }
//     log("firestore-${useNative ? "NATIVE" : "DART"} Initialized");
//     return service;
//   }
// }

// // Interface / Base class
// // Combination of abstract methods that must be implemented, and concrete methods that are shared.
// abstract class FirebaseService {
//   /// /////////////////////////////////////////////////
//   /// Concrete Methods
//   /// //////////////////////////////////////////////////

//   /// shared setUserId method
//   late Stream<AppUser?> onUserChanged;
//   final StreamController<AppUser?> _controller =
//       StreamController<AppUser?>.broadcast();
//   AppUser? get currentUser => _currentUser;
//   String? get userId => _userId;
//   set seCurrentUser(AppUser? newUser) => _currentUser = newUser;
//   AppUser? _currentUser;
//   String? _userId;
//   set setUserId(String newUserId) {
//     _userId = newUserId;
//   }

//   bool isDesktopAuth = false;
//   FirebaseService() {
//     onUserChanged = _controller.stream;
//   }
//   List<String> get userPath => [FireIds.users, userId ?? ""];
//   List<String> get userEduPath => [...userPath, FireIds.more, FireIds.profile];
//   List<String> get userSavesPath => [...userPath, FireIds.more, FireIds.saves];

//   // Helper method for getting a path from keys, and optionally prepending the scope (users/email)
//   String getPathFromKeys(List<String> keys, {bool addUserPath = false}) {
//     String path =
//         addUserPath ? userPath.followedBy(keys).join("/") : keys.join("/");
//     if (FirebaseFactory.useNative) {
//       return path.replaceAll("//", "/");
//     }
//     return path;
//   }

//   /////////////////////////////////////////////////////////
//   // USERS
//   /////////////////////////////////////////////////////////
//   @override
//   Future<AppUser?> getUserData() async {
//     try {
//       Map<String, dynamic>? data = await getDoc([]);
//       return data == null ? null : AppUser.fromJson(data);
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }

//   Future<void> setNewUser(String? uid) async {
//     if (uid != null) {
//       setUserId = uid;
//       final userMap = await getDoc(userPath);
//       AppUser user = AppUser.fromJson(userMap!);
//       final profileMap = await getDoc(userEduPath);
//       if (profileMap != null) {
//         final moduleIds = List<String>.from(profileMap[FireIds.modules]);
//         List<ModuleModel> modules = await getModules(moduleIds);
//         CourseModel course =
//             await getCourse(profileMap[FireIds.course] as String);
//         user = user.copyWith(
//           modules: modules,
//           course: course,
//           level: profileMap[FireIds.level] as int?,
//         );
//       }
//       seCurrentUser = user;
//     } else {
//       seCurrentUser = null;
//     }

//     userChange();
//   }

//   /////////////////////////////////////////////////////////
//   // MODULES
//   /////////////////////////////////////////////////////////
//   Future<List<ModuleModel>> getModuleNames(
//       List<ModuleModel>? userModules) async {
//     List<ModuleModel> modules = [];
//     if (userModules != null) {
//       for (final module in userModules) {
//         final json = await getDoc([FireIds.modules, module.id]);
//         modules.add(ModuleModel.fromJson(json!));
//       }
//     }
//     return modules;
//   }

//   Future<List<ModuleModel>> getModules(List<String> moduleIds) async {
//     List<ModuleModel> modules = [];
//     for (final moduleId in moduleIds) {
//       final json = await getDoc([FireIds.modules, moduleId]);
//       modules.add(ModuleModel.fromJson(json!));
//     }
//     return modules;
//   }

//   //todo :: add temp module to avoid re reading them again and again
//   Future<List<ModuleModel>> getSortedModules({
//     int? maxLevel,
//     String? courseId,
//   }) async {
//     List<ModuleModel> modules = [];

//     if (maxLevel == null) {
//       maxLevel = currentUser!.level;
//       courseId = currentUser!.course!.id;
//     }

//     final json = await getDoc(
//         [FireIds.courses, courseId!, FireIds.more, FireIds.details]);
//     final courseDetails = ModuleManager.fromJson(json!);

//     modules = courseDetails.modules!;
//     return await Future.wait(modules
//         .where(
//       (element) => element.level! <= maxLevel!,
//     )
//         .map(
//       (e) async {
//         final json = await getDoc([FireIds.modules, e.id]);
//         return e.copyWith(name: json!["name"]);
//       },
//     ).toList());
//     // for (var e in course.modules) {
//     //   final json = await getDoc([FireIds.modules, e.id]);
//     //   modules.add(e.copyWith(name: json!["name"]));
//     // }
//     // return modules;
//   }

//   ///////////////////////////////////////////////////
//   // Abstract Methods
//   //////////////////////////////////////////////////
//   @override
//   void init();

//   ///////////////////////////////////////////////////
//   // Auth
//   //////////////////////////////////////////////////
//   Future<bool> signInWithMicrosoft([bool reauthenticate = false]) async {
//     return _currentUser != null;
//   }

//   @override
//   bool get isSignedIn;
//   @override
//   @mustCallSuper
//   Future<void> signOut() async {
//     seCurrentUser = null;
//     userChange();
//   }

//   void streamUserChange() {
//     log("Streaming current user");

//     _controller.add(currentUser);
//     log("Done streaming current user");
//   }

//   /// check if is authentication for desktop
//   /// if so: send the id token to the desktop app
//   /// if not: set the current user on app model
//   /// then Stream user change anyway;
//   void userChange() {
//     if (isDesktopAuth) {
//       // AuthenticateDesktopCommand().run();
//     } else {
//       // SetCurrentUserCommand().run();
//     }
//     streamUserChange();
//   }

//   Future<String?> getAccessToken() async {
//     return "get access token base method";
//   }

//   String? get getRefreshToken => "get refresh token base method";

//   ///////////////////////////////////////////////////
//   // Course Details
//   //////////////////////////////////////////////////
//   Future<List<CourseModel>> getAllCourses() async {
//     final course = await getCollection([FireIds.courses]);
//     return course?.map((doc) => CourseModel.fromJson(doc)).toList() ?? [];
//   }

//   Future<CourseModel> getCourse(String courseId) async {
//     final doc = await getDoc([FireIds.courses, courseId]);
//     return CourseModel.fromJson(doc!);
//   }

//   Future<void> updateUser(Map<String, dynamic> json) async {
//     await updateDoc(userPath, json);
//   }

//   ///Whew we update user profile[course,year and modules] here
//   ///this is the one that is used in the settings setup page
//   Future<void> updateUserEducation({
//     required List<String> modules,
//     required int level,
//     required String courseId,
//   }) async {
//     Map<String, dynamic> json = {
//       FireIds.modules: modules,
//       FireIds.level: level,
//       FireIds.course: courseId,
//     };
//     if (currentUser!.course == null) {
//       await addDoc([FireIds.more], json,
//           documentId: FireIds.profile, addUserPath: true);
//     } else {
//       await updateDoc(userEduPath, json);
//     }
//   }

//   ///////////////////////////////////////////////////
//   // DOCUMENTS
//   //////////////////////////////////////////////////
//   Future<RemoteDocModel?> getUploadedFile(String id) async {
//     try {
//       Map<String, dynamic>? data = await getDoc([FireIds.uploads, id]);
//       if (data == null) {
//         return null;
//       } else {
//         final doc = RemoteDocModel.fromJson(data);
//         return doc.copyWith(modules: await getModuleNames(doc.modules));
//       }
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }

//   final int documentsPerPage = 20;
//   Future<FetchedRemoteDocs> getUserUploads();

//   ///on uploads
//   final uploadsStreamController = StreamController<int>.broadcast();
//   Stream<int> get uploadsStream => uploadsStreamController.stream;

//   ///editing
//   final _uploadEditStreamController =
//       StreamController<RemoteDocModel>.broadcast();
//   Stream<RemoteDocModel> get uploadEditStream =>
//       _uploadEditStreamController.stream;

//   Future<void> addProduct(Map<String, dynamic> product) async {
//     // Add product to database
//     _updateProductStream();
//   }

//   void _updateProductStream() {
//     // final updatedProducts = getProductsFromDatabase();
//     // _uploadsStreamController.add(updatedProducts);
//   }

//   Future<void> updateUpload(Map<String, dynamic> json) async {
//     //create something to work with after uploads
//     //prevent losing the id/reinserting it again
//     final edited = RemoteDocModel.fromJson(json);
//     final id = json["id"];
//     json.remove("id");
//     await updateDoc([FireIds.uploads, id], json);
//     final editedFinal =
//         edited.copyWith(modules: await getModuleNames(edited.modules));
//     _uploadEditStreamController.add(editedFinal);
//   }

//   Future<void> downloadFile(Map<String, dynamic> json) async {
//     final url = json['url'];
//     json.remove('url');
//     await addDoc([FireIds.increaseDownload], json);
//     // Use the download URL to trigger a browser download
//     html.AnchorElement(href: url)
//       ..setAttribute('download', '_blank')
//       ..click();
//   }

//   @override
//   Future<Map<String, dynamic>?> getDoc(List<String> keys);
//   @override
//   Future<List<Map<String, dynamic>>?> getCollection(List<String> keys);

//   @override
//   Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
//       {String? documentId, bool addUserPath = false});
//   @override
//   Future<void> updateDoc(List<String> keys, Map<String, dynamic> json);
//   @override
//   Future<void> deleteDoc(List<String> keys);

//   ///////////////////////////////////////////////////
//   // Files - uploads
//   @override
//   Stream<double> uploadFile(String name, [String? path, XFile? asset]);
// }

// bool checkKeysForNull(List<String> keys) {
//   if (keys.contains(null)) {
//     log("ERROR: invalid key was passed to firestore: $keys");
//     return false;
//   }
//   return true;
// }

import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/domain/entities/auth_user.dart';
