class Module {
  final String id;

  /// level of the module
  /// at which level is taught/ required
  final int? level;

  /// semester  level
  final int? semester;

  ///name of the module/shortened
  final String? name;

  Module({
    required this.id,
    this.level,
    this.semester,
    this.name,
  });
}
