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

Map<String, dynamic> _$$ModuleModelImplToJson(_$ModuleModelImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lvl', instance.level);
  writeNotNull('sem', instance.semester);
  writeNotNull('name', instance.name);
  return val;
}
