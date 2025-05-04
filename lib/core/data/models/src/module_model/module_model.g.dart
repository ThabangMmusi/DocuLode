// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModuleModelImpl _$$ModuleModelImplFromJson(Map<String, dynamic> json) =>
    _$ModuleModelImpl(
      id: json['id'] as String,
      level: (json['lvl'] as num?)?.toInt(),
      semester: (json['sem'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ModuleModelImplToJson(_$ModuleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.level case final value?) 'lvl': value,
      if (instance.semester case final value?) 'sem': value,
      if (instance.name case final value?) 'name': value,
    };
