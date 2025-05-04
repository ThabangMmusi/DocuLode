import 'module.dart';

class Course {
  ///module ID
  final String id;

  /// number of year it will take to finish the qualification
  final int? duration;

  ///name of the course/shortened
  final String? name;

  ///course that come before this one/ related to this one
  final List<String>? predecessors;

  Course({
    required this.id,
    this.predecessors,
    this.duration,
    this.name,
  });
}
