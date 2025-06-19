class Module {
  final String id;

  /// institution ID
  final String? moduleId;

  /// level of the module
  /// at which level is taught/ required
  final int? year;

  /// semester  level
  final int? semester;

  ///name of the module/shortened
  final String? name;

  Module({
    required this.id,
    this.moduleId,
    this.year,
    this.semester,
    this.name,
  });
}
