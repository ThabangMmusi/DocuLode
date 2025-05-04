// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModuleManagerImpl _$$ModuleManagerImplFromJson(Map<String, dynamic> json) =>
    _$ModuleManagerImpl(
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      predecessors: (json['predecessors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ModuleManagerImplToJson(_$ModuleManagerImpl instance) =>
    <String, dynamic>{
      if (instance.modules?.map((e) => e.toJson()).toList() case final value?)
        'modules': value,
      if (instance.predecessors case final value?) 'predecessors': value,
    };
