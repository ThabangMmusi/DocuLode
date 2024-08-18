// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModuleModelImpl _$$ModuleModelImplFromJson(Map<String, dynamic> json) =>
    _$ModuleModelImpl(
      id: json['id'] as String?,
      level: (json['level'] as num).toInt(),
      name: json['name'] as String,
      courses:
          (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ModuleModelImplToJson(_$ModuleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'courses': instance.courses,
    };
