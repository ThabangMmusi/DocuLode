// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => _ModuleModel(
      id: json['id'] as String,
      moduleId: json['module_id'] as String?,
      name: json['module_name'] as String?,
    );

Map<String, dynamic> _$ModuleModelToJson(_ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.moduleId case final value?) 'module_id': value,
      if (instance.name case final value?) 'module_name': value,
    };
