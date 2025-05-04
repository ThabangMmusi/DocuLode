// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseModelImpl _$$CourseModelImplFromJson(Map<String, dynamic> json) =>
    _$CourseModelImpl(
      id: json['id'] as String,
      duration: (json['du'] as num?)?.toInt(),
      name: json['name'] as String?,
      predecessors: (json['predecessors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.duration case final value?) 'du': value,
      if (instance.name case final value?) 'name': value,
      if (instance.predecessors case final value?) 'predecessors': value,
    };
