import 'package:doculode/config/index.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/utils/cache_manager.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/constants/app_text.dart';
import 'package:doculode/services/data_ids.dart';

// lib/data/services/supabase_service_impl.dart

import 'dart:async';
// ... other necessary imports from before (supabase_flutter, models, logger, etc.)

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:doculode/core/core.dart';

class SupabaseServiceImpl extends DatabaseService {
  late final SupabaseClient _client; // Supabase specific client
  final CacheManager _cacheManager = CacheManager();

  // Constructor can be simple if DatabaseService handles stream init
  // SupabaseServiceImpl() : super();

  @override
  Future<void> init() async {
    // Initialize cache
    await super.init();
    
    // 1. Retrieve Supabase URL and Anon Key
    //    (Make sure these are provided when you run/build your app)
    const String supabaseUrl = AppKeys.supabaseUrl;
    const String supabaseAnonKey = AppKeys.supabaseAnonKey;

    // Basic check to ensure the variables are provided
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      // In a real app, you might want to throw an error or handle this more gracefully,
      // perhaps by falling back to mock data for development if keys are missing.
      log('********************************************************************************');
      log('ERROR: SUPABASE_URL or SUPABASE_ANON_KEY not found in environment variables.');
      log('Please provide them using --dart-define during flutter run/build.');
      log('Example: flutter run --dart-define="SUPABASE_URL=YOUR_URL" --dart-define="SUPABASE_ANON_KEY=YOUR_KEY"');
      log('********************************************************************************');
      // Depending on your app's requirements, you might:
      // throw Exception("Supabase URL/Key not configured.");
      throw ArgumentError(
          "Supabase URL and Anon Key are required for SupabaseService initialization.");
      // Or, for development, you could hardcode test keys here (NOT for production):
      // if (supabaseUrl.isEmpty) supabaseUrl = "YOUR_DEV_URL";
      // if (supabaseAnonKey.isEmpty) supabaseAnonKey = "YOUR_DEV_KEY";
      // Ensure you handle this state appropriately if you proceed without valid keys.
    }
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    _client = Supabase.instance.client;
    log("SupabaseServiceImpl: Initialized");
    // signOut();
    // Listen to Supabase auth state changes and use the shared handler
    _client.auth.onAuthStateChange.listen((AuthState data) async {
      log("SupabaseServiceImpl Auth Event: [32m${data.event}[0m, User: ${data.session?.user.id}");
      // log(_client.auth.currentUser.toString());
      await super.handleAuthUserChanged(
          data.session?.user); // Pass the Supabase User object
      hasCheckedInitialUser = true; // Mark initial user check as complete
    });

    // No initial user check here; rely solely on the auth state stream for user propagation
  }

  // Mark as override and still protected if that's the intent
  @override
  @protected
  Future<AppUser?> fetchAppUserData(
      String userId, String? emailFromAuthProvider) async {
    // This is the Supabase-specific implementation to get AppUser data
    // from 'users' and 'user_profiles' tables.
    log("SupabaseServiceImpl: _fetchAppUserData called for rawAuthId: $userId");
    try {
      final userProfileDataResponse = await getUserProfileData(userId);

      AppUser? appUser;

      if (userProfileDataResponse != null) {
        appUser = AppUser.fromJson(userProfileDataResponse);

        final userAcademicDataResponse = await _client
            .from(DataIds.academics)
            .select()
            .eq(DataIds.id, userId)
            .maybeSingle();

        if (userAcademicDataResponse != null) {
          final String? courseId =
              userAcademicDataResponse['course_id'] as String?;
          final List<String>? selectedModuleIds =
              (userAcademicDataResponse['selected_module_ids'] as List<dynamic>?)
                  ?.cast<String>();
          final int? year = userAcademicDataResponse['level'] as int?;

          CourseModel? courseModel;
          if (courseId != null) courseModel = await getCourse(courseId);

          List<ModuleModel> moduleModels = [];
          if (selectedModuleIds != null && selectedModuleIds.isNotEmpty) {
            final modulesNameData = await _client
                .from(DataIds.modules)
                .select('id, name')
                .inFilter('id', selectedModuleIds);
            moduleModels = modulesNameData
                .map((m) => ModuleModel(id: m['id'], name: m['name']))
                .toList();
          }
          appUser = appUser.copyWith(
              course: courseModel, modules: moduleModels, year: year);
        } // Mark user data as loaded
      } else {
        // User exists in auth.users but not in your public 'users' table yet.
        // This can happen right after signup if your trigger/function hasn't run or isn't set up.
        // Create a minimal AppUser.
        log("SupabaseServiceImpl: Public user data not found for $userId. Creating minimal AppUser.");
        appUser = AppUser(
            id: userId,
            email: emailFromAuthProvider ?? '',
            names: ''); // Provide defaults
      }
      return appUser;
    } catch (e, st) {
      logError(
          "SupabaseServiceImpl: Error in _fetchAppUserData for $userId: $e\n$st");
      return null; // Or throw to indicate failure
    }
  }

  /// Get basic user info by userId
  Future<Map<String, dynamic>?> getUserProfileData(String userId) async {
    final response = await _client
        .from(DataIds.profile)
        .select()
        .eq(DataIds.id, userId)
        .maybeSingle();
    if (response == null) return null;
    response['id'] = userId; // Ensure the ID is included
    return response;
  }

  /// Get modules linked to a userId
  Future<List<Map<String, dynamic>>> getUserModules(String userId) async {
    // final response =
    return await _client
        .from(DataIds.userModules)
        .select('${DataIds.modules} (${DataIds.id}, ${DataIds.moduleName})')
        .eq(DataIds.userId, userId);

    // Flatten the response if needed
    // final modules = response
    //     .map((row) => row[DataIds.modules] as Map<String, dynamic>)
    //     .toList();

    // return modules;
  }

  @override
  bool get isSignedIn =>
      _client.auth.currentUser != null && super.currentUser != null;

  // --- User Stream: Emit current value on listen ---
  // @override
  // Stream<AppUser?> get onUserChangedWithInitial async* {
  //   yield super.currentUser;
  //   yield* super.onUserChanged;
  // }

  @override
Future<void> signOut() async {
  try {
    await _client.auth.signOut();
    log("SupabaseServiceImpl: Supabase sign out successful.");
    // Clear cache on sign out
    await super.signOut();
  } catch (e) {
    logError("SupabaseServiceImpl: Error during Supabase sign out: $e");
    // Decide if you want to throw or just log
  }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final session = _client.auth.currentSession;
    return session != null && session.accessToken.isNotEmpty;
  }

  @override
  Future<void> signInWithMicrosoft() async {
    try {
      final String? redirectTo = kIsWeb ? null : tVerifyEmailProtocol;
      await _client.auth.signInWithOAuth(
        OAuthProvider.azure,authScreenLaunchMode: LaunchMode.externalApplication,
        redirectTo: redirectTo,
        scopes: 'openid email profile user.read', 
      );
    } catch (e) {
      throw ServerException("SupabaseServiceImpl: Microsoft Sign-In Error: $e");
    }
  }

  @override
  Future<void> requestOtpWithEmail(String email) async {
    try {
      // Validate email format before making the request
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        final errorMessage = 'Email address "$email" is invalid';
        logError('Requesting OTP error: $errorMessage');
        throw ServerException(errorMessage);
      }

      await _client.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
        emailRedirectTo: tVerifyEmailProtocol,
      );
    } on AuthException catch (e) {
      final errorMessage = 'Requesting OTP error: ${e.message}';
      logError(errorMessage);
      throw ServerException(e.message);
    } catch (e) {
      final errorMessage = 'Unexpected error during OTP request: $e';
      logError(errorMessage);
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<void> verifyEmailOtp(String email, String otp) async {
    try {
      final AuthResponse res = await _client.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.magiclink,
      );

      if (res.user != null && res.session == null) {
        // User created, confirmation email sent. Session is null until email is confirmed.
        logSuccess(
            'Sign up successful. Please check your email for verification link.');

        // You might want to navigate the user to a page saying "Check your email"
      } else if (res.user != null && res.session != null) {
        // This case happens if "Enable email confirmations" is OFF in Supabase settings
        // Or if the user was already confirmed (e.g., re-signing up a confirmed email might not always work as expected, depends on config)
        logSuccess(
            'Sign up successful and user is already confirmed (or confirmation disabled). User: ${res.user!.id}');
      } else if (res.user == null && res.session == null) {
        // This might indicate an issue or that the user already exists and is unconfirmed.
        // Supabase by default doesn't throw an error if the user already exists but is unconfirmed,
        // it resend the confirmation email. Check Supabase logs.
        logSuccess(
            'Sign up initiated. If user exists and is unconfirmed, confirmation resent. Check email.');
      }
    } on AuthException catch (e) {
      logError('Sign up error: ${e.message}');
      throw ServerException(e.message);
      // Handle specific errors, e.g., user already registered and confirmed, weak otp, etc.
    } catch (e) {
      logError('Unexpected error during sign up: $e');
      throw ServerException('Unexpected error during sign up: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async =>
      _client.auth.currentSession?.accessToken;

  @override
  String? get getRefreshToken => _client.auth.currentSession?.refreshToken;

  // --- Implementations for other abstract methods ---

  @override
  Future<AppUser?> getUserData() async {
    // This typically means re-fetching the user data for the currently authenticated user.
    // The super.currentUser might be stale or you want to ensure it's fresh.
    if (super.currentAuthUserId != null) {
      AppUser? appUser = await fetchAppUserData(
          super.currentAuthUserId!, _client.auth.currentUser?.email);
      super.setCurrentUser(
          appUser, super.currentAuthUserId); // Update shared state
      return appUser;
    }
    return null;
  }

  @override
  Future<void> updateUserPublicProfile(
      Map<String, dynamic> jsonDataToUpdate) async {
    if (super.currentAuthUserId == null) throw Exception("User not signed in.");
    try {
      await _client
          .from(DataIds.profile)
          .update(jsonDataToUpdate)
          .eq(DataIds.id, super.currentAuthUserId!);
      // Refresh user data after update
      await getUserData();
    } catch (e) {
      logError("SupabaseServiceImpl: Error updating user public profile: $e");
      throw ServerException("Failed to update public profile: $e");
    }
  }

  @override
  Future<void> updateUserEducationProfile({
    List<String>? selectedModuleIds,
    int? level,
    String? courseId,
  }) async {
    if (super.currentAuthUserId == null) throw Exception("User not signed in.");
    Map<String, dynamic> jsonToUpdate = {};
    if (selectedModuleIds != null) {
      jsonToUpdate[DataIds.moduleIds] = selectedModuleIds;
    }
    if (level != null) jsonToUpdate[DataIds.year] = level;
    if (courseId != null) jsonToUpdate[DataIds.courseId] = courseId;

    if (jsonToUpdate.isEmpty) return;

    try {
      await _client.from(DataIds.academics).upsert(
        {...jsonToUpdate, 'user_id': super.currentAuthUserId!},
        onConflict: 'user_id',
      );
      await getUserData(); // Refresh user data
    } catch (e) {
      logError(
          "SupabaseServiceImpl: Error updating user education profile: $e");
      throw ServerException("Failed to update education profile: $e");
    }
  }

  @override
  Future<List<CourseModel>> getAllCourses() async {
    const cacheKey = 'all_courses';
    final cachedCourses = await _cacheManager.get<List<dynamic>>(cacheKey,
        maxAge: DatabaseService.defaultCacheDuration);
    
    if (cachedCourses != null) {
      // Return cached courses
      log('Using cached courses');
      return cachedCourses.map((e) => CourseModel.fromJson(e)).toList();
    }
    
    // Fetch from network
    final courses = await fetchAllCourses();
    
    // Cache the result
    if (courses.isNotEmpty) {
      await _cacheManager.set(cacheKey, courses.map((c) => c.toJson()).toList());
    }
    
    return courses;
  }
  
  @override
  Future<List<CourseModel>> fetchAllCourses() async {
    try {
      final response = await _client.from(DataIds.courses).select();
      return response.map((doc) => CourseModel.fromJson(doc)).toList();
    } catch (e) {
      logError("SupabaseServiceImpl: Error getting all courses: $e");
      return [];
    }
  }

  @override
  Future<CourseModel> getCourse(String courseId) async {
    final cacheKey = 'course_$courseId';
    final cachedCourse = await _cacheManager.get<Map<String, dynamic>>(cacheKey,
        maxAge: DatabaseService.defaultCacheDuration);
    
    if (cachedCourse != null) {
      // Return cached course
      log('Using cached course: $courseId');
      return CourseModel.fromJson(cachedCourse);
    }
    
    // Fetch from network
    final course = await fetchCourse(courseId);
    
    // Cache the result
    await _cacheManager.set(cacheKey, course.toJson());
    
    return course;
  }
  
  @override
  Future<CourseModel> fetchCourse(String courseId) async {
    try {
      final response = await _client
          .from(DataIds.courses)
          .select()
          .eq(DataIds.id, courseId)
          .single();
      return CourseModel.fromJson(response);
    } catch (e) {
      logError("SupabaseServiceImpl: Error getting course $courseId: $e");
      throw ServerException("Failed to get course: $e");
    }
  }

  @override
  Future<List<ModuleModel>> getModulesByIds(List<String> moduleIds) async {
    if (moduleIds.isEmpty) return [];
    
    final cacheKey = 'modules_${moduleIds.join("_")}';
    final cachedModules = await _cacheManager.get<List<dynamic>>(cacheKey, 
        maxAge: DatabaseService.defaultCacheDuration);
    
    if (cachedModules != null) {
      // Return cached modules
      return cachedModules.map((e) => ModuleModel.fromJson(e)).toList();
    }
    
    // Fetch from network
    final modules = await fetchModulesByIds(moduleIds);
    
    // Cache the result
    if (modules.isNotEmpty) {
      await _cacheManager.set(cacheKey, modules.map((m) => m.toJson()).toList());
    }
    
    return modules;
  }
  
  @override
  Future<List<ModuleModel>> fetchModulesByIds(List<String> moduleIds) async {
    if (moduleIds.isEmpty) return [];
    try {
      final response = await _client
          .from(DataIds.modules)
          .select()
          .inFilter(DataIds.id, moduleIds);
      return response.map((json) => ModuleModel.fromJson(json)).toList();
    } catch (e) {
      logError("SupabaseServiceImpl: Error fetching modules by IDs: $e");
      return [];
    }
  }

  @override
  Future<List<ModuleModel>> getMultipleYearsModules({
    String? courseId,
    int? semester,
    int startYear = 1,
    int? endYear,
  }) async {
    // Using the current user from the base class for context if parameters are null
    final effectiveCourseId = courseId ?? super.currentUser?.course?.id;
    final effectiveEndYear = endYear ?? super.currentUser?.year;
    final effectiveSemester = semester ?? super.currentUser?.semester;

    if (effectiveEndYear == null || effectiveCourseId == null) {
      log("SupabaseServiceImpl: Cannot get sorted modules - insufficient info.");
      return [];
    }

    try {
      List<ModuleModel> allModules = [];

      // Loop through each year from start to end
      for (int currentYear = startYear;
          currentYear <= effectiveEndYear;
          currentYear++) {
        // Get modules for current year
        final List<Map<String, dynamic>> courseModulesData = await _client
            .from(DataIds.courseModules)
            .select(DataIds.courseModuleKeys)
            .eq(DataIds.courseId, effectiveCourseId)
            .eq(DataIds.year, currentYear)
            .eq(DataIds.semester, effectiveSemester as int);

        if (courseModulesData.isEmpty) continue;

        // Get module IDs for current year
        List<String> yearModuleIds = courseModulesData
            .map((row) => row[DataIds.moduleId] as String)
            .toList();

        // Get the modules using the existing method
        final modules = await getModulesByIds(yearModuleIds);

        // Update year and semester info
        final yearModules = modules
            .map((module) => module.copyWith(
                  year: currentYear,
                  semester: effectiveSemester,
                ))
            .toList();

        allModules.addAll(yearModules);
      }

      return allModules;
    } catch (e, st) {
      logError(
          "SupabaseServiceImpl: Error in getSortedModules for course $effectiveCourseId: $e\n$st");
      return [];
    }
  }

  @override
  Future<List<ModuleModel>> getSingleYearModules({
    required String courseId,
    required int semester,
    required int year,
  }) async {
    try {
      // Get modules for the specific year and semester
      final List<Map<String, dynamic>> courseModulesData = await _client
          .from(DataIds.courseModules)
          .select(DataIds.courseModuleKeys)
          .eq(DataIds.courseId, courseId)
          .eq(DataIds.year, year)
          .eq(DataIds.semester, semester);

      if (courseModulesData.isEmpty) return [];

      // Get module IDs
      List<String> moduleIds = courseModulesData
          .map((row) => row[DataIds.moduleId] as String)
          .toList();

      // Get the modules using the existing method
      final modules = await getModulesByIds(moduleIds);

      // Add year and semester info to each module
      return modules
          .map((module) => module.copyWith(
                year: year,
                semester: semester,
              ))
          .toList();
    } catch (e, st) {
      logError(
          "SupabaseServiceImpl: Error getting modules for course $courseId, year $year, semester $semester: $e\n$st");
      return [];
    }
  }

  @override
  Future<RemoteDocModel?> getUploadedFile(String uploadId) async {
    try {
      final data = await _client
          .from(DataIds.uploads)
          .select()
          .eq(DataIds.id, uploadId)
          .maybeSingle();
      if (data == null) return null;
      final doc = RemoteDocModel.fromJson(data);
      List<ModuleModel> populatedModules = [];
      // Assuming doc.modules might be List<ModuleModel> stubs with only IDs, or List<String> of IDs
      final moduleIdsToFetch = (doc.modules?.map((m) => m.id) ?? []).toList();
      if (moduleIdsToFetch.isNotEmpty) {
        populatedModules = await getModulesByIds(moduleIdsToFetch);
      }
      return doc.copyWith(
          modules:
              populatedModules.isNotEmpty ? populatedModules : doc.modules);
    } catch (e) {
      logError(
          "SupabaseServiceImpl: Error getting uploaded file $uploadId: $e");
      return null;
    }
  }

  @override
  Future<FetchedRemoteDocs> getUserUploads({int page = 1}) async {
    if (super.currentAuthUserId == null) {
      return FetchedRemoteDocs(docs: [], hasMore: false);
    }
    final int documentsPerPage = 20; // Or make this a configurable class member
    final from = (page - 1) * documentsPerPage;
    final to = from + documentsPerPage - 1;
    try {
      final response = await _client
          .from(DataIds.uploads)
          .select()
          .eq(DataIds.userId, super.currentAuthUserId!)
          .order(DataIds.uploadedAt, ascending: false)
          .range(from, to);
      final docs =
          response.map((json) => RemoteDocModel.fromJson(json)).toList();
      return FetchedRemoteDocs(
          docs: docs, hasMore: docs.length == documentsPerPage);
    } catch (e) {
      logError("SupabaseServiceImpl: Error getting user uploads: $e");
      throw ServerException(e.toString());
    }
  }

  @override
Future<void> updateUpload(Map<String, dynamic> json) async {
  final String? uploadId = json[DataIds.id] as String?;
  if (uploadId == null) {
    /* log error */ return;
  }
  Map<String, dynamic> updateData = Map.from(json)..remove(DataIds.id);
  try {
    await _client
        .from(DataIds.uploads)
        .update(updateData)
        .eq(DataIds.id, uploadId);
    final updatedDocData = await getUploadedFile(uploadId);
    if (updatedDocData != null) {
      super.uploadEditController.add(updatedDocData); // Notify shared stream
    }
  } catch (e) {/* log error, throw */}
}

@override
  Future<void> invalidateModuleCache() async {
    // Create a pattern for module cache keys
    // Since we can't directly access all keys, we'll invalidate specific known patterns
    
    // Clear all module caches by pattern
    // This is a simplified approach - in a real implementation, you might want to
    // keep track of all module cache keys you create for more precise invalidation
    await _cacheManager.clear(); // For now, clear all cache as a simple solution
    log('Module cache invalidated');
  }
  
  @override
  Future<void> invalidateCourseCache() async {
    // Invalidate the all courses cache
    await _cacheManager.remove('all_courses');
    
    // For individual course caches, we would need to know which courses were cached
    // For now, we'll clear all cache as a simple solution
    await _cacheManager.clear();
    log('Course cache invalidated');
  }

  @override
  Future<void> downloadFile(
      Map<String, dynamic> jsonWithStoragePathAndId) async {
    final String? storagePath =
        jsonWithStoragePathAndId['storage_path'] as String?;
    final String? uploadId = jsonWithStoragePathAndId[DataIds.id] as String?;
    if (storagePath == null) {
      /* log error */ return;
    }
    try {
      final String downloadUrl =
          _client.storage.from(DataIds.uploadsBucket).getPublicUrl(storagePath);
      if (uploadId != null && super.currentAuthUserId != null) {
        await _client.from(DataIds.downloadTracking).insert({
          DataIds.uploadId: uploadId,
          DataIds.userId: super.currentAuthUserId!,
          DataIds.downloadedAt: DateTime.now().toIso8601String(),
        });
      }
      if (kIsWeb) {
        // html.AnchorElement(href: downloadUrl)
        //   ..setAttribute('download', storagePath.split('/').last)
        //   ..setAttribute('target', '_blank')
        //   ..click();
      } else {
        log("Non-web download: $downloadUrl");
      }
    } catch (e) {/* log error, throw */}
  }

  // --- Generic CRUD Implementations ---
  @override
  Future<Map<String, dynamic>?> getDoc(List<String> keys) async {
    if (keys.length < 2) return null;
    try {
      return await _client
          .from(keys.first)
          .select()
          .eq(DataIds.id, keys[1])
          .maybeSingle();
    } catch (e) {
      logError("Supabase getDoc error: $e");
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?> getCollection(List<String> keys) async {
    if (keys.isEmpty) return null;
    try {
      return await _client.from(keys.first).select();
    } catch (e) {
      logError("Supabase getCollection error: $e");
      return null;
    }
  }

  @override
  Future<String> addDoc(List<String> keys, Map<String, dynamic> json,
      {String? documentId, bool addUserPath = false}) async {
    if (keys.isEmpty) throw ArgumentError("Table name missing");
    Map<String, dynamic> dataToInsert = Map.from(json);
    if (documentId != null) dataToInsert[DataIds.id] = documentId;
    // Note: addUserPath is a Firebase concept; for Supabase, user_id should be in `json` if table requires it.
    try {
      final response = await _client
          .from(keys.first)
          .insert(dataToInsert)
          .select(DataIds.id)
          .single();
      return response[DataIds.id].toString();
    } catch (e) {
      logError("Supabase addDoc error: $e");
      throw ServerException("Add doc failed");
    }
  }

  @override
  Future<void> updateDoc(List<String> keys, Map<String, dynamic> json) async {
    if (keys.length < 2) throw ArgumentError("Insufficient keys");
    try {
      await _client.from(keys.first).update(json).eq(DataIds.id, keys[1]);
    } catch (e) {
      logError("Supabase updateDoc error: $e");
      throw ServerException("Update doc failed");
    }
  }

  @override
  Future<void> deleteDoc(List<String> keys) async {
    if (keys.length < 2) throw ArgumentError("Insufficient keys");
    try {
      await _client.from(keys.first).delete().eq(DataIds.id, keys[1]);
    } catch (e) {
      logError("Supabase deleteDoc error: $e");
      throw ServerException("Delete doc failed");
    }
  }

  // --- File Operations ---
  @override
  Stream<double> uploadFile(String name, [String? path, XFile? asset]) async* {
    if (asset == null || super.currentAuthUserId == null) {
      yield 0.0;
      return;
    }
    yield 0.0; // Signal start
    try {
      final fileBytes = await asset.readAsBytes();
      final String storagePath =
          '${super.currentAuthUserId!}/${path ?? ""}/$name'
              .replaceAll("//", "/"); // Ensure clean path
      await _client.storage.from(DataIds.uploadsBucket).uploadBinary(
            storagePath,
            fileBytes,
            fileOptions: FileOptions(
                cacheControl: '3600',
                upsert: true,
                contentType: asset.mimeType),
          );
      super
          .uploadsEventController
          .add(0); // Signal completion via shared stream
      yield 1.0; // Signal 100%
    } catch (e) {
      logError("SupabaseServiceImpl: Error uploading file $name: $e");
      yield 0.0; // Or throw error
      throw ServerException("Failed to upload file: $e");
    }
  }
}
