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
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      predecessors: (json['predecessors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('du', instance.duration);
  writeNotNull('name', instance.name);
  writeNotNull('modules', instance.modules?.map((e) => e.toJson()).toList());
  writeNotNull('predecessors', instance.predecessors);
  return val;
}
