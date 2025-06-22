import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/core/utils/cache_manager.dart';
import 'package:doculode/core/utils/index.dart';
import 'package:doculode/services/supabase_service_impl.dart';

// lib/data/services/database_service.dart

import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart'; // For @mustCallSuper

import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter_sdk;

class DatabaseFactory {
  static bool _initComplete = false;

  // Determine which platforms we can use the native sdk on
  // static bool get useNative =>
  //     DeviceOS.isMobileOrWeb; // || UniversalPlatform.isMacOS;

  static DatabaseService? create() {
    // FirebaseService service =
    //     useNative ? NativeFirebaseService() : DartFirebaseService();
    // FirebaseService service = NativeFirebaseService();
    // DatabaseService service = SupabaseServiceImpl();
    // if (_initComplete == false) {
    //   _initComplete = true;
    //   service.init();
    // }
    // // log("firestore-${useNative ? "NATIVE" : "DART"} Initialized");
    // return service;
  }
}

abstract class DatabaseService {
  // --- Shared State & Controllers ---
  final StreamController<AppUserModel?> _userController =
      StreamController<AppUserModel?>.broadcast();
  late Stream<AppUserModel?> onUserChanged;

  AppUserModel? _currentUser;
  AppUserModel? get currentUser => _currentUser;

  /// Indicates whether the initial user check (auth state) has completed.
  /// This is false until the first auth state event is processed.
  bool hasCheckedInitialUser = false;

  String? _currentAuthUserId;
  String? get currentAuthUserId => _currentAuthUserId;

  String? get userId => _currentUser?.id;

  final StreamController<int> _uploadsEventController =
      StreamController<int>.broadcast();
  StreamController<int> get uploadsEventController => _uploadsEventController;
  Stream<int> get uploadsStream => _uploadsEventController.stream;

  final StreamController<RemoteDocModel> _uploadEditController =
      StreamController<RemoteDocModel>.broadcast();
  StreamController<RemoteDocModel> get uploadEditController =>
      _uploadEditController;
  Stream<RemoteDocModel> get uploadEditStream => _uploadEditController.stream;

  /// Cache manager for database operations
  final CacheManager _cacheManager = CacheManager();

  /// Default cache duration for database operations
  static const Duration defaultCacheDuration = Duration(minutes: 30);

  DatabaseService() {
    onUserChanged = _userController.stream;
  }

  // --- Abstract Initialization ---
  Future<void> init() async {
    await initCache();
  }

  /// Initialize the cache manager
  @protected
  Future<void> initCache() async {
    await _cacheManager.init();
  }

  // --- Shared User Management Logic ---
  @protected
  void setCurrentUser(AppUserModel? newUser, String? rawAuthId) {
    _currentUser = newUser;
    _currentAuthUserId = rawAuthId;
    _userController.add(_currentUser);
    hasCheckedInitialUser = true;
  }

  Future<void> handleAuthUserChanged(dynamic authProviderUser) async {
    if (authProviderUser == null) {
      setCurrentUser(null, null);
    } else {
      // await signOut();
      String rawId;
      String? email;

      if (authProviderUser is supabase_flutter_sdk.User) {
        // Example for Supabase
        rawId = authProviderUser.id;
        email = authProviderUser.email;
      }
      // else if (authProviderUser is OtherAuthProviderUserType) { // Example for another provider
      //   rawId = authProviderUser.someIdField;
      //   email = authProviderUser.someEmailField;
      // }
      else {
        logError(
            "DatabaseService: Unknown auth provider user type: ${authProviderUser.runtimeType}");
        setCurrentUser(null, null);
        return;
      }
      AppUserModel? appUser = await fetchAppUserData(rawId, email);
      setCurrentUser(appUser, rawId);
    }
  }

  @protected
  Future<AppUserModel?> fetchAppUserData(String rawAuthId, String? email);

  @mustCallSuper
  Future<void> signOut() async {
    // Clear cache on sign out
    await clearCache();
  }

  Future<bool> isUserLoggedIn();
  Future<void> signInWithMicrosoft();
  Future<void> requestOtpWithEmail(String email);
  Future<void> verifyEmailOtp(String email, String otp);
  Future<String?> getAccessToken();
  String? get getRefreshToken;

  // --- Abstract User Profile / Data Methods ---
  Future<AppUserModel?> getUserData();
  Future<void> updateUserPublicProfile(Map<String, dynamic> jsonDataToUpdate);
  Future<void> updateUserEducationProfile({
    List<String>? selectedModuleIds,
    int? level,
    String? courseId,
  });

  // --- Abstract Course/Module Methods ---

  /// Retrieves all courses, with caching support
  ///
  /// This method will check the cache first before fetching from the network
  Future<List<CourseModel>> getAllCourses();

  /// Network implementation of getAllCourses
  ///
  /// This method should be implemented by subclasses to fetch courses from the network
  @protected
  Future<List<CourseModel>> fetchAllCourses();

  /// Retrieves a course by ID, with caching support
  ///
  /// This method will check the cache first before fetching from the network
  Future<CourseModel> getCourse(String courseId);

  /// Network implementation of getCourse
  ///
  /// This method should be implemented by subclasses to fetch a course from the network
  @protected
  Future<CourseModel> fetchCourse(String courseId);

  /// Retrieves modules by IDs, with caching support
  ///
  /// This method will check the cache first before fetching from the network
  Future<List<ModuleModel>> getModulesByIds(List<String> moduleIds);

  /// Network implementation of getModulesByIds
  ///
  /// This method should be implemented by subclasses to fetch modules from the network
  @protected
  Future<List<ModuleModel>> fetchModulesByIds(List<String> moduleIds);

  /// Retrieves a sorted list of modules based on the provided filters
  /// @param courseId - Optional. The ID of the course to filter modules by
  /// @param semester - Optional. The semester to filter by (e.g. "1", "2")
  /// @param startYear - Optional. The starting academic year to include (default: 1)
  /// @param endYear - Optional. The ending academic year to end at
  Future<List<ModuleModel>> getMultipleYearsModules({
    String? courseId,
    int? semester,
    int startYear = 1,
    int? endYear,
  });
  Future<List<ModuleModel>> getSingleYearModules(
      {required String courseId, required int semester, required int year});
  // --- Abstract Upload/Document Methods ---
  Future<RemoteDocModel?> getUploadedFile(String uploadId);
  Future<FetchedRemoteDocs> getUserUploads({int page = 1});
  Future<void> updateUpload(Map<String, dynamic> json);
  Future<void> downloadFile(Map<String, dynamic> jsonWithStoragePathAndId);

  // --- Abstract Generic CRUD ---
  Future<Map<String, dynamic>?> getDoc(List<String> keys);
  Future<List<Map<String, dynamic>>?> getCollection(List<String> keys);
  Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
      {String? documentId, bool addUserPath = false});
  Future<void> updateDoc(List<String> keys, Map<String, dynamic> json);
  Future<void> deleteDoc(List<String> keys);

  // --- Abstract File Operations ---
  Stream<double> uploadFile(String name, [String? path, XFile? asset]);

  // --- Cache Control Methods ---

  /// Clear all cached data
  Future<void> clearCache() async {
    await _cacheManager.clear();
  }

  /// Clear cache for a specific key
  Future<void> invalidateCache(String key) async {
    await _cacheManager.remove(key);
  }

  /// Clear cache for modules
  Future<void> invalidateModuleCache() async {
    // Implementation will depend on how module caching is structured
    // This is a placeholder that should be overridden by implementations
  }

  /// Clear cache for courses
  Future<void> invalidateCourseCache() async {
    // Implementation will depend on how course caching is structured
    // This is a placeholder that should be overridden by implementations
  }

  // --- User Stream: Emit current value on listen ---
  // Stream<AppUserModel?> get onUserChangedWithInitial async* {
  //   yield _currentUser;
  //   yield* _userController.stream;
  // }
}
