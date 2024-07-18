// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocModelImpl _$$DocModelImplFromJson(Map<String, dynamic> json) =>
    _$DocModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      ext: json['ext'] as String,
      name: json['name'] as String,
      module: json['module'] as String,
      uploadDate: json['uploadDate'] as String,
      uploadedBy: json['uploadedBy'] as String,
      like:
          (json['like'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      dislike: (json['dislike'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      downloads: (json['downloads'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DocModelImplToJson(_$DocModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'ext': instance.ext,
      'name': instance.name,
      'module': instance.module,
      'uploadDate': instance.uploadDate,
      'uploadedBy': instance.uploadedBy,
      'like': instance.like,
      'dislike': instance.dislike,
      'downloads': instance.downloads,
    };
