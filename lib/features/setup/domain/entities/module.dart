class Module {
  final String? id;

  /// level of the module
  /// at which level is taught/ required
  final int level;

  ///name of the module/shortened
  final String name;

  ///course that teaches this module
  ///list because one module can be taught in diff qualification
  final List<String> courses;

  Module({
    this.id,
    required this.level,
    required this.name,
    required this.courses,
  });
}
