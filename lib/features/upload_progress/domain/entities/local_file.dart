import 'package:file_selector/file_selector.dart';

class LocalDoc {
  LocalDoc({
    required this.path,
    required this.name,
    required this.asset,
  });
  final String? path;
  final String name;

  /// the actual file containing bytes and other stuff
  /// used only my mobile and web
  final XFile? asset;
}
