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
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      level: (json['level'] as num?)?.toInt(),
      semester: (json['semester'] as num?)?.toInt(),
      course: _$JsonConverterFromJson<String, CourseModel>(
          json['course'], const CourseConverter().fromJson),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.names case final value?) 'names': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.email case final value?) 'email': value,
      if (instance.photoUrl case final value?) 'photoUrl': value,
      if (instance.level case final value?) 'level': value,
      if (instance.semester case final value?) 'semester': value,
      if (_$JsonConverterToJson<String, CourseModel>(
              instance.course, const CourseConverter().toJson)
          case final value?)
        'course': value,
      if (instance.modules?.map((e) => e.toJson()).toList() case final value?)
        'modules': value,
      if (instance.type case final value?) 'type': value,
      if (instance.token case final value?) 'token': value,
      if (instance.refreshToken case final value?) 'refreshToken': value,
    };

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
