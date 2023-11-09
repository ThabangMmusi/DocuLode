import 'package:cloud_firestore/cloud_firestore.dart';

import '../../_utils/logger.dart';
import '../../commands/commands.dart';
import '../../models/course_model.dart';

class CoursesRepository extends BaseAppCommand {
  late CourseModel? course;
  Future<CourseModel?> getCourseDetails() async {
    try {
      course = await firebase.getCourseDetails();
      return course;
    } catch (e) {
      logError("courses from firebase: $e");
    }
    return null;
  }
}
