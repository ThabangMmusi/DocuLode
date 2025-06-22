import 'dart:io';
import 'package:doculode/core/constants/data_ids.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/error/exceptions.dart';
import 'package:doculode/core/utils/cache_manager.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/features/setup/data/datasources/setup_data_source.dart';
import 'package:doculode/features/setup/domain/entities/academic_submission_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetupDataSourceImpl implements SetupDataSource {
  final SupabaseClient _client;
  final CacheManager _cacheManager = CacheManager();

  SetupDataSourceImpl(this._client);

  @override
  Future<List<CourseModel>> getAvailableCourses() async {
    const cacheKey = 'all_courses';
    final cachedCourses = await _cacheManager.get<List<dynamic>>(cacheKey,
        maxAge: DatabaseService.defaultCacheDuration);

    if (cachedCourses != null) {
      // Return cached courses
      log('Using cached courses');
      return cachedCourses.map((e) => CourseModel.fromJson(e)).toList();
    }

    // Fetch from network
    final courses = await _fetchAllCourses();

    // Cache the result
    if (courses.isNotEmpty) {
      await _cacheManager.set(
          cacheKey, courses.map((c) => c.toJson()).toList());
    }

    return courses;
  }

  Future<List<CourseModel>> _fetchAllCourses() async {
    try {
      final response = await _client.from(DataIds.courses).select();
      return response.map((doc) => CourseModel.fromJson(doc)).toList();
    } catch (e) {
      logError("SupabaseServiceImpl: Error getting all courses: $e");
      return [];
    }
  }

  @override
  Future<List<ModuleModel>> getModules(
      {required String courseId,
      required int year,
      required int semester}) async {
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
      return await _getModulesByIds(moduleIds);

    } catch (e, st) {
      logError(
          "SupabaseServiceImpl: Error getting modules for course $courseId, year $year, semester $semester: $e\n$st");
      return [];
    }
  }

  Future<List<ModuleModel>> _getModulesByIds(List<String> moduleIds) async {
    if (moduleIds.isEmpty) return [];

    final cacheKey = 'modules_${moduleIds.join("_")}';
    final cachedModules = await _cacheManager.get<List<dynamic>>(cacheKey,
        maxAge: DatabaseService.defaultCacheDuration);

    if (cachedModules != null) {
      // Return cached modules
      return cachedModules.map((e) => ModuleModel.fromJson(e)).toList();
    }

    // Fetch from network
    final modules = await _fetchModulesByIds(moduleIds);

    // Cache the result
    if (modules.isNotEmpty) {
      await _cacheManager.set(
          cacheKey, modules.map((m) => m.toJson()).toList());
    }

    return modules;
  }

  Future<List<ModuleModel>> _fetchModulesByIds(List<String> moduleIds) async {
    if (moduleIds.isEmpty) return [];
    try {
      final response = await _client
          .from(DataIds.modules)
          .select()
          .inFilter(DataIds.id, moduleIds);
      return response.map((json) => ModuleModel.fromJson(json)).toList();
    } catch (e) {
      logError("AuthDataSourceImpl: Error fetching modules by IDs: $e");
      return [];
    }
  }

  @override
  Future<String> uploadImage(File imageFile) async {
    // Assuming a bucket name like 'profile_images' and a path based on user ID or a unique ID
    // final filePath =
    // 'profile_images/${databaseService.userId}';
    // return await databaseService.uploadFile(
    //     'profile_images', filePath, imageFile); // Assuming null for XFile for now
    return "Not Implemented";
  }

  @override
  Future<void> submitRegistration(AcademicSubmissionEntity submission) async {
    final session = _client.auth.currentSession;
    if (session == null) throw Exception("User not signed in.");

    Map<String, dynamic> json = {
      DataIds.userId: session.user.id,
      DataIds.courseId: submission.selectedCourseId,
      DataIds.year: submission.selectedYear,
      DataIds.semester: submission.selectedSemester,
    };

    try {
      await _client.from(DataIds.academics).insert(json);

      final List<Map<String, dynamic>> rowsToInsert =
          submission.selectedModuleIds.map((moduleId) {
        return {
          DataIds.userId: session.user.id,
          DataIds.moduleId: moduleId,
        };
      }).toList();

      await _client.from(DataIds.userModules).insert(rowsToInsert);
    } catch (e) {
      logError(
          "SupabaseServiceImpl: Error updating user education profile: $e");
      throw ServerException("Failed to update education profile: $e");
    }
  }
}
