class DataIds {
  // -- general ID--
  static const String id = "id";
  static const String userId = "'user_id'";

  // -- user table --
  static const String profile = "profile";
  // -- user fields --
  // id is the auth user id
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String email = "email";
  static const String photoUrl = "photo_url";
  static String get userKeys =>
      [firstName, lastName, email, photoUrl].join(",");

  // -- user profiles table --
  static const String academics = "academics";
  // -- user profile fields --
  // id is the auth user id
  static const String courseId = "course_id";
  static const String year = "year";

  // -- USER modules table --
  static const String userModules = "user_modules";
  // array of module IDs liked from the modules table
  static const String moduleIds = "module_ids";

  // -- modules table --
  static const String modules = "modules";
  // -- modules fields --
  // id is the module ID
  static const String moduleName = "module_name";

  // -- courses table --
  static const String courses = "courses";
  // -- courses fields --
  // id is the course ID
  static const String courseName = "course_name";
  static const String duration = "duration";
  static String get courseKeys => [courseId, year].join(",");

  // -- course_modules table --
  static const String courseModules = "course_modules";
  // -- course_modules fields --
  static const String moduleId = "module_id";
  static const String semester = "semester";

  static String courseModuleKeys = [moduleId, year, semester].join(",");

  // -- uploads table fields --
  static const String uploadedAt = "uploaded_at";

  // -- download_tracking table fields --
  static const String downloadedAt = "downloaded_at";
  static const String uploadId = "upload_id";

  static const String name = "name";

  static const String uploads = "uploads";
  static const String courseDetails = "course_details";
  static const String saves = "saves";
  static const String downloadTracking = "download_tracking";
  static const String uploadsBucket = "uploads_bucket";
  static const String profileImagesBucket = "profile_images";
}
