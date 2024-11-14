// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemoteDocModelImpl _$$RemoteDocModelImplFromJson(Map<String, dynamic> json) =>
    _$RemoteDocModelImpl(
      id: json['id'] as String?,
      url: json['url'] as String? ?? "",
      uploaded: _$JsonConverterFromJson<Timestamp, DateTime>(
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

Map<String, dynamic> _$$RemoteDocModelImplToJson(
    _$RemoteDocModelImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['url'] = instance.url;
  writeNotNull(
      'uploaded',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.uploaded, const TimestampConverter().toJson));
  val['uid'] = instance.uid;
  val['size'] = instance.size;
  val['access'] = const AccessConverter().toJson(instance.access);
  writeNotNull(
      'type',
      _$JsonConverterToJson<int, UploadCategory>(
          instance.type, const CategoryConverter().toJson));
  writeNotNull('modules',
      instance.modules?.map(const ModuleConverter().toJson).toList());
  val['name'] = instance.name;
  val['like'] = instance.like;
  val['dislike'] = instance.dislike;
  val['downloads'] = instance.downloads;
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
