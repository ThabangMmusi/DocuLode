// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:its_shared/core/core.dart';

import '../../models.dart';

part 'remote_doc_model.freezed.dart';
part 'remote_doc_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class AccessConverter implements JsonConverter<AccessType, int> {
  const AccessConverter();

  @override
  AccessType fromJson(int access) => AccessTypeConverter.fromInt(access);

  @override
  int toJson(AccessType access) => access.asInt;
}

class CategoryConverter implements JsonConverter<UploadCategory, int> {
  const CategoryConverter();

  @override
  UploadCategory fromJson(int access) =>
      UploadCategoryConverter.fromInt(access);

  @override
  int toJson(UploadCategory access) => access.asInt;
}

@freezed
class RemoteDocModel extends RemoteDoc with _$RemoteDocModel {
  const RemoteDocModel._();
  const factory RemoteDocModel({
    String? id,
    @Default("") String url,
    @TimestampConverter() DateTime? uploaded,
    @Default("") String uid,
    @Default("") String size,
    @AccessConverter() @Default(AccessType.unpublished) AccessType access,
    @CategoryConverter() UploadCategory? type,
    @ModuleConverter() List<ModuleModel>? modules,
    @Default("") String name,
    @Default([]) List<String> like,
    @Default([]) List<String> dislike,
    @Default(0) int downloads,
  }) = _RemoteDocModel;

  String get ext => name.split('.').last;
  String get onlyName => name.replaceAll(".$ext", "");
  bool get isPublic => access == AccessType.public;
  bool get isPublished => access == AccessType.private || isPublic;

  factory RemoteDocModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteDocModelFromJson(json);
}
