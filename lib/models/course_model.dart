import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final String name;
  final String code;
  final String school;
  final String year;
  final List<String>? modules;
  const CourseModel({
    required this.code,
    required this.name,
    required this.school,
    required this.year,
    this.modules,
  });

  @override
  List<Object?> get props => [
        name,
        school,
        year,
        modules,
      ];

  String get schoolFullName => school.split("|").last;
  String get schoolAbbrName => school.split("|").first;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'school': school,
      'year': year,
      'modules': modules,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> snapshot) {
    List<String> formatList(List<dynamic> modules) {
      return modules.map((e) => e.toString()).toList();
    }

    return CourseModel(
      code: snapshot["id"],
      name: snapshot['name'] as String,
      school: snapshot['school'] as String,
      year: snapshot['year'] as String,
      modules: formatList(snapshot['modules']),
    );
  }
}
