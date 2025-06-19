// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModuleManager _$ModuleManagerFromJson(Map<String, dynamic> json) =>
    _ModuleManager(
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      predecessors: (json['predecessors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ModuleManagerToJson(_ModuleManager instance) =>
    <String, dynamic>{
      if (instance.modules?.map((e) => e.toJson()).toList() case final value?)
        'modules': value,
      if (instance.predecessors case final value?) 'predecessors': value,
    };
