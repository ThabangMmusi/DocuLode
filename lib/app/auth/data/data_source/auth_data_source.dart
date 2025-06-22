import 'package:doculode/core/constants/data_ids.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/utils/cache_manager.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Stream<AppUserModel?> get onAuthStateChanged;
  Future<void> signOut();

  Future<AppUserModel?> getCurrentUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient _client;
  AppUserModel? _currentUser;
  final CacheManager _cacheManager = CacheManager();

  AppUserModel? get currentUser => _currentUser;
  AuthDataSourceImpl(this._client);

  @override
  Stream<AppUserModel?> get onAuthStateChanged {
    try {
      return _client.auth.onAuthStateChange.asyncMap((data) async {
        log("AuthDataSourceImpl Auth Event: [32m${data.event}[0m, User: ${data.session?.user.id}");
        final supabaseUser = data.session?.user;
        if (supabaseUser == null) return null;
        String? rawId = supabaseUser.id;
        String? email = supabaseUser.email;
        AppUserModel? appUser = await _fetchAppUserData(rawId, email);
        if (appUser == null) return null;
        return appUser;
      });
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
void setCurrentUser(AppUserModel? newUser) {
    _currentUser = newUser;
  }
  Future<AppUserModel?> _fetchAppUserData(
      String userId, String? emailFromAuthProvider) async {
    // This is the Supabase-specific implementation to get AppUser data
    // from 'users' and 'user_profiles' tables.
    log("AuthDataSourceImpl: _fetchAppUserData called for rawAuthId: $userId");
    try {
      final userProfileDataResponse = await _getUserProfileData(userId);
      AppUserModel? appUser;

      if (userProfileDataResponse != null) {
        appUser = AppUserModel.fromJson(userProfileDataResponse);

        final userAcademicDataResponse = await _client
            .from(DataIds.academics)
            .select()
            .eq(DataIds.userId, userId)
            .maybeSingle();

        if (userAcademicDataResponse != null) {
          final String? courseId =
              userAcademicDataResponse[DataIds.courseId] as String?;
          final int? year = userAcademicDataResponse[DataIds.year] as int?;
          final int? semester =
              userAcademicDataResponse[DataIds.semester] as int?;
          CourseModel? courseModel;
          if (courseId != null) courseModel = await _getCourse(courseId);
          final List<ModuleModel> moduleModels = await _getUserModules(userId);
          // List<ModuleModel> moduleModels = await _getModulesByIds(moduleIds);
          appUser = appUser.copyWith(
            course: courseModel,
            modules: moduleModels,
            year: year,
            semester: semester,
          );
        }
      } else {
        // User exists in auth.users but not in your public 'users' table yet.
        // This can happen right after signup if your trigger/function hasn't run or isn't set up.
        // Create a minimal AppUser.
        log("AuthDataSourceImpl: Public user data not found for $userId. Creating minimal AppUser.");
        appUser = AppUserModel(
            id: userId,
            email: emailFromAuthProvider ?? '',
            names: ''); // Provide defaults
      }
      return appUser;
    } catch (e, st) {
      logError(
          "AuthDataSourceImpl: Error in _fetchAppUserData for $userId: $e\n$st");
      return null; // Or throw to indicate failure
    }
  }

  Future<Map<String, dynamic>?> _getUserProfileData(String userId) async {
    final response = await _client
        .from(DataIds.profile)
        .select()
        .eq(DataIds.id, userId)
        .maybeSingle();
    if (response == null) return null;
    response[DataIds.id] = userId;
    return response;
  }

  Future<List<ModuleModel>> _getUserModules(String userId) async {
    final response = await _client
        .from(DataIds.userModules)
        .select('${DataIds.modules} (${DataIds.id}, ${DataIds.moduleName})')
        .eq(DataIds.userId, userId);

    // Flatten the response if needed
    final modules =
        response.map((json) => ModuleModel.fromJson(json[DataIds.modules])).toList();

    return modules;
  }

  Future<CourseModel> _getCourse(String courseId) async {
    final cacheKey = 'course_$courseId';
    final cachedCourse = await _cacheManager.get<Map<String, dynamic>>(cacheKey,
        maxAge: Duration(minutes: 30));

    if (cachedCourse != null) {
      // Return cached course
      log('Using cached course: $courseId');
      return CourseModel.fromJson(cachedCourse);
    }

    // Fetch from network
    final course = await _fetchCourse(courseId);

    // Cache the result
    await _cacheManager.set(cacheKey, course.toJson());

    return course;
  }

  Future<CourseModel> _fetchCourse(String courseId) async {
    try {
      final response = await _client
          .from(DataIds.courses)
          .select()
          .eq(DataIds.id, courseId)
          .single();
      return CourseModel.fromJson(response);
    } catch (e) {
      logError("AuthDataSourceImpl: Error getting course $courseId: $e");
      throw ServerException("Failed to get course: $e");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    await clearCache();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
  @override
  Future<AppUserModel?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
  // --- Cache Control Methods ---

  /// Clear all cached data
  Future<void> clearCache() async {
    await _cacheManager.clear();
  }

  /// Clear cache for a specific key
  Future<void> invalidateCache(String key) async {
    await _cacheManager.remove(key);
  }


}
