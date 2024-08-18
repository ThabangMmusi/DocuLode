class Course {
  ///module ID
  final String? id;

  /// number of year it will take to finish the qualification
  final int duration;

  ///name of the course/shortened
  final String name;

  ///course that come before this one/ related to this one
  final List<String>? predecessors;

  Course({
    this.id,
    required this.duration,
    required this.name,
    this.predecessors,
  });
}
