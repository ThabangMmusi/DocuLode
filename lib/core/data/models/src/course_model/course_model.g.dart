// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => _CourseModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      name: json['course_name'] as String?,
    );

Map<String, dynamic> _$CourseModelToJson(_CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.courseId case final value?) 'course_id': value,
      if (instance.duration case final value?) 'duration': value,
      if (instance.name case final value?) 'course_name': value,
    };
