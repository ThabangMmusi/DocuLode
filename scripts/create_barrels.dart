import 'dart:io';

void main() async {

  await _createBarrelFiles('lib');

}

Future<void> _createBarrelFiles(String directory) async {
  final dir = Directory(directory);
  if (!await dir.exists()) return;

  // Skip .dart_tool and .git directories
  if (directory.contains('.dart_tool') || directory.contains('.git')) {
    return;
  }

  // Get all Dart files in the current directory
  final dartFiles = await dir
      .list()
      .where((entity) => entity is File && entity.path.endsWith('.dart'))
      .toList();

  // Create barrel file if there are Dart files
  if (dartFiles.isNotEmpty) {
    final barrelFile = File('${dir.path}/index.dart');
    final exports = dartFiles
        .map((file) => "export '${file.uri.pathSegments.last}';")
        .join('\n');
    await barrelFile.writeAsString(exports);

  }

  // Recursively process subdirectories
  final subDirs =
      await dir.list().where((entity) => entity is Directory).toList();

  for (final subDir in subDirs) {
    await _createBarrelFiles(subDir.path);
  }
}
