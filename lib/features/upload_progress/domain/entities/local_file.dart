import 'package:file_selector/file_selector.dart';

class LocalDoc {
  LocalDoc({
    required this.path,
    required this.name,
    required this.asset,
  });
  final String? path;
  final String name;
  final XFile? asset;
}
