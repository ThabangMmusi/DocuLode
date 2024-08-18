import '../../_utils/logger.dart';
import '../../commands/commands.dart';
import '../../core/common/models/course_model.dart';

class CoursesRepository extends BaseAppCommand {
  late CourseDetailsModel? course;
  Future<CourseDetailsModel?> getCourseDetails() async {
    try {
      course = await firebase.getCourseDetails();
      return course;
    } catch (e) {
      logError("courses from firebase: $e");
    }
    return null;
  }
}
