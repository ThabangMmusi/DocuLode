import 'package:doculode/core/domain/entities/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
sealed class CourseModel extends Course with _$CourseModel {
  CourseModel._() : super(id: "");
  factory CourseModel({
    required String id,
    @JsonKey(name: "course_id") String? courseId,
    int? duration,
    @JsonKey(name: "course_name") String? name,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}
