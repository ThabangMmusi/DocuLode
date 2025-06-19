import 'dart:io';
import 'package:path/path.dart' as path;

class ProjectAnalyzer {
  final String projectRoot;
  final List<ImportIssue> issues = [];
  final Map<String, Set<String>> classDefinitions = {};
  final Map<String, Set<String>> methodDefinitions = {};

  ProjectAnalyzer(this.projectRoot);

  void analyze() {
  
    final libDir = Directory(path.join(projectRoot, 'lib'));
    _analyzeDirectory(libDir);
    _generateReport();
  }

  void _analyzeDirectory(Directory dir) {
    for (var entity in dir.listSync()) {
      if (entity is File && entity.path.endsWith('.dart')) {
        _analyzeFile(entity);
      } else if (entity is Directory) {
        _analyzeDirectory(entity);
      }
    }
  }

  void _analyzeFile(File file) {
    final content = file.readAsStringSync();
    final relativePath = path.relative(file.path, from: projectRoot);

    // Extract imports
    final imports = content
        .split('\n')
        .where((line) => line.trim().startsWith('import '))
        .map((line) => line.trim())
        .toList();

    // Extract class definitions
    final classMatches = RegExp(r'class\s+(\w+)').allMatches(content);
    for (var match in classMatches) {
      final className = match.group(1);
      if (className != null) {
        classDefinitions.putIfAbsent(className, () => {}).add(relativePath);
      }
    }

    // Extract method definitions
    final methodMatches = RegExp(r'(\w+)\s*\([^)]*\)\s*\{').allMatches(content);
    for (var match in methodMatches) {
      final methodName = match.group(1);
      if (methodName != null) {
        methodDefinitions.putIfAbsent(methodName, () => {}).add(relativePath);
      }
    }

    // Check for undefined references
    _checkUndefinedReferences(content, relativePath, imports);
  }

  void _checkUndefinedReferences(
      String content, String filePath, List<String> imports) {
    // Check for class usage
    final classUsageMatches = RegExp(r'\b(\w+)\s*[<{]').allMatches(content);
    for (var match in classUsageMatches) {
      final className = match.group(1);
      if (className != null &&
          !_isBuiltInType(className) &&
          !_isImported(className, imports) &&
          classDefinitions.containsKey(className)) {
        issues.add(ImportIssue(
            file: filePath,
            type: IssueType.undefinedClass,
            name: className,
            suggestion:
                'Add import for $className from ${classDefinitions[className]?.first}'));
      }
    }

    // Check for method usage
    final methodUsageMatches = RegExp(r'\.(\w+)\(').allMatches(content);
    for (var match in methodUsageMatches) {
      final methodName = match.group(1);
      if (methodName != null &&
          !_isImported(methodName, imports) &&
          methodDefinitions.containsKey(methodName)) {
        issues.add(ImportIssue(
            file: filePath,
            type: IssueType.undefinedMethod,
            name: methodName,
            suggestion:
                'Add import for $methodName from ${methodDefinitions[methodName]?.first}'));
      }
    }
  }

  bool _isBuiltInType(String name) {
    final builtInTypes = {
      'String',
      'int',
      'double',
      'bool',
      'List',
      'Map',
      'Set',
      'void',
      'dynamic',
      'Object',
      'Null',
      'Future',
      'Stream'
    };
    return builtInTypes.contains(name);
  }

  bool _isImported(String name, List<String> imports) {
    return imports.any((import) => import.contains(name));
  }

  void _generateReport() {




    for (var issue in issues) {




    }






  }
}

class ImportIssue {
  final String file;
  final IssueType type;
  final String name;
  final String suggestion;

  ImportIssue({
    required this.file,
    required this.type,
    required this.name,
    required this.suggestion,
  });
}

enum IssueType {
  undefinedClass,
  undefinedMethod,
  missingImport,
}

void main() {
  final analyzer = ProjectAnalyzer(Directory.current.path);
  analyzer.analyze();
}
