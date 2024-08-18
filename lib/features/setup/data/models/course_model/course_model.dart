import 'package:its_shared/features/setup/domain/entities/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class CourseModel extends Course with _$CourseModel {
  const factory CourseModel({
    String? id,
    required int duration,
    required String name,
    List<String>? predecessors,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}
