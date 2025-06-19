// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteDocModel _$RemoteDocModelFromJson(Map<String, dynamic> json) =>
    _RemoteDocModel(
      id: json['id'] as String?,
      url: json['url'] as String? ?? "",
      uploaded: _$JsonConverterFromJson<String, DateTime>(
          json['uploaded'], const TimestampConverter().fromJson),
      uid: json['uid'] as String? ?? "",
      size: json['size'] as String? ?? "",
      access: json['access'] == null
          ? AccessType.unpublished
          : const AccessConverter().fromJson((json['access'] as num).toInt()),
      type: _$JsonConverterFromJson<int, UploadCategory>(
          json['type'], const CategoryConverter().fromJson),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => const ModuleConverter().fromJson(e as String))
          .toList(),
      name: json['name'] as String? ?? "",
      like:
          (json['like'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      dislike: (json['dislike'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      downloads: (json['downloads'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RemoteDocModelToJson(_RemoteDocModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'url': instance.url,
      if (_$JsonConverterToJson<String, DateTime>(
              instance.uploaded, const TimestampConverter().toJson)
          case final value?)
        'uploaded': value,
      'uid': instance.uid,
      'size': instance.size,
      'access': const AccessConverter().toJson(instance.access),
      if (_$JsonConverterToJson<int, UploadCategory>(
              instance.type, const CategoryConverter().toJson)
          case final value?)
        'type': value,
      if (instance.modules?.map(const ModuleConverter().toJson).toList()
          case final value?)
        'modules': value,
      'name': instance.name,
      'like': instance.like,
      'dislike': instance.dislike,
      'downloads': instance.downloads,
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
