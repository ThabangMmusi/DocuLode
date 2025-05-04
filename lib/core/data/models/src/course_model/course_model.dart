// ignore_for_file: invalid_annotation_target

import 'package:its_shared/core/domain/entities/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
sealed class CourseModel extends Course with _$CourseModel {
  const factory CourseModel({
    required String id,
    @JsonKey(name: 'du') int? duration,
    String? name,
    List<String>? predecessors,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}
