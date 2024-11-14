// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String?,
      names: json['names'] as String?,
      surname: json['surname'] as String?,
      level: (json['level'] as num?)?.toInt(),
      course: _$JsonConverterFromJson<String, CourseModel>(
          json['course'], const CourseConverter().fromJson),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => const ModuleConverter().fromJson(e as String))
          .toList(),
      type: json['type'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('names', instance.names);
  writeNotNull('surname', instance.surname);
  writeNotNull('level', instance.level);
  writeNotNull(
      'course',
      _$JsonConverterToJson<String, CourseModel>(
          instance.course, const CourseConverter().toJson));
  writeNotNull('modules',
      instance.modules?.map(const ModuleConverter().toJson).toList());
  writeNotNull('type', instance.type);
  writeNotNull('token', instance.token);
  writeNotNull('refreshToken', instance.refreshToken);
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
