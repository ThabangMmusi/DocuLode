import 'dart:io';

void main() async {


  // Define the import mappings for files
  final fileMappings = {
    'themes.dart': 'config/index.dart',
    'injection_container.dart': 'config/index.dart',
    'styles.dart': 'config/index.dart',
    'app_keys.dart': 'config/index.dart',
    'firebase_options.dart': 'config/index.dart',
    'responsive.dart': 'core/constants/index.dart',
  };

  // Define the import mappings for directories
  final directoryMappings = {
    'commands/': 'core/commands/index.dart',
    'operations/': 'core/operations/index.dart',
    'constants/': 'core/constants/index.dart',
    'animated/': 'widgets/animated/index.dart',
    'core/': 'core/index.dart',
    'config/': 'config/index.dart',
    'widgets/': 'widgets/index.dart',
  };

  // Get all Dart files in the lib directory
  final dartFiles = await _getDartFiles('lib');

  for (final file in dartFiles) {
  
    await _updateImports(file, fileMappings, directoryMappings);
  }


}

Future<List<String>> _getDartFiles(String directory) async {
  final List<String> files = [];
  final dir = Directory(directory);

  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      files.add(entity.path);
    }
  }

  return files;
}

Future<void> _updateImports(
  String filePath,
  Map<String, String> fileMappings,
  Map<String, String> directoryMappings,
) async {
  final file = File(filePath);
  if (!await file.exists()) return;

  String content = await file.readAsString();
  bool modified = false;
  final imports = <String>{};

  // Update file imports
  for (final entry in fileMappings.entries) {
    final oldImport = entry.key;
    final newImport = entry.value;

    // Create regex pattern to match the import
    final pattern = RegExp(r"import\s+['\']package:doculode/$oldImport['\1]\;"
    );

    if (pattern.hasMatch(content)) {
      // Replace the old import with the new one
      content = content.replaceAll(
        pattern,
        "import 'package:doculode/$newImport';",
      );
      imports.add("package:doculode/$newImport");
      modified = true;
    }
  }

  // Update directory imports
  for (final entry in directoryMappings.entries) {
    final oldPath = entry.key;
    final newPath = entry.value;

    // Create regex pattern to match the import
    final pattern = RegExp(
      r"import\s+['\']package:doculode/$oldPath([^'\']\s]+)['\']\;"    );

    if (pattern.hasMatch(content)) {
      // Replace the old import with the new one
      content = content.replaceAllMapped(
        pattern,
        (match) {
          imports.add("package:doculode/$newPath");
          return "import 'package:doculode/$newPath';";
        },
      );
      modified = true;
    }
  }

  // If the file was modified, write the changes back
  if (modified) {
    // Remove duplicate imports
    final uniqueImports = imports.toList()..sort();
    final importSection =
        uniqueImports.map((imp) => "import '$imp';").join('\n');

    // Replace all imports with the new import section
    content = content.replaceAll(
      RegExp('import\\s+[\'"]package:doculode/.*?[\'"];', multiLine: true),
      '',
    );

    // Add the new import section at the top
    content = '$importSection\n\n$content';

    await file.writeAsString(content);

  }
}
