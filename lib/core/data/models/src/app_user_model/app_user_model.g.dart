// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
      id: json['id'] as String,
      names: json['names'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      year: (json['year'] as num?)?.toInt(),
      semester: (json['semester'] as num?)?.toInt(),
      course: _$JsonConverterFromJson<String, CourseModel>(
          json['course'], const CourseConverter().fromJson),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => const ModuleConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.names case final value?) 'names': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.email case final value?) 'email': value,
      if (instance.photoUrl case final value?) 'photoUrl': value,
      if (instance.year case final value?) 'year': value,
      if (instance.semester case final value?) 'semester': value,
      if (_$JsonConverterToJson<String, CourseModel>(
              instance.course, const CourseConverter().toJson)
          case final value?)
        'course': value,
      if (instance.modules?.map(const ModuleConverter().toJson).toList()
          case final value?)
        'modules': value,
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
