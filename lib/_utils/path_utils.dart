import 'package:its_shared/_utils/logger.dart';
import 'package:path_provider/path_provider.dart';

class PathUtil {
  static Future<String?> get dataPath async {
    String? result;

    try {
      return (await getApplicationSupportDirectory()).path;
    } catch (e) {
      log("$e");
    }
    return result;
  }

  static Future<String> get homePath async {
    return "~/";
  }
}
