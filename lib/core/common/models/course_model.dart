import 'package:equatable/equatable.dart';

class CourseDetailsModel extends Equatable {
  final String name;
  final String code;
  final String year;
  final List<String> modules;
  const CourseDetailsModel({
    required this.code,
    required this.name,
    required this.year,
    this.modules = const [],
  });

  @override
  List<Object?> get props => [
        name,
        year,
        modules,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'year': year,
      'modules': modules,
    };
  }

  factory CourseDetailsModel.fromJson(Map<String, dynamic> snapshot) {
    List<String> formatList(List<dynamic> modules) {
      return modules.map((e) => e.toString()).toList();
    }

    return CourseDetailsModel(
      code: snapshot["id"],
      name: snapshot['name'] as String,
      year: snapshot['year'] as String,
      modules: formatList(snapshot['modules']),
    );
  }
}
