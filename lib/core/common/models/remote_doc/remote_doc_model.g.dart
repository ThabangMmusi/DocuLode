// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemoteDocModelImpl _$$RemoteDocModelImplFromJson(Map<String, dynamic> json) =>
    _$RemoteDocModelImpl(
      id: json['id'] as String?,
      url: json['url'] as String,
      uploaded:
          const TimestampConverter().fromJson(json['uploaded'] as Timestamp),
      uid: json['uid'] as String,
      size: json['size'] as String,
      name: json['name'] as String? ?? "",
      type: (json['type'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      modules: (json['modules'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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
        _$RemoteDocModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'uploaded': const TimestampConverter().toJson(instance.uploaded),
      'uid': instance.uid,
      'size': instance.size,
      'name': instance.name,
      'type': instance.type,
      'modules': instance.modules,
      'like': instance.like,
      'dislike': instance.dislike,
      'downloads': instance.downloads,
    };
