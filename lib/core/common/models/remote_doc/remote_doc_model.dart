import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:its_shared/core/core.dart';

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

@freezed
@JsonSerializable(includeIfNull: false)
class RemoteDocModel extends RemoteDoc with _$RemoteDocModel {
  const RemoteDocModel._();
  const factory RemoteDocModel({
    String? id,
    required String url,
    @TimestampConverter() required DateTime uploaded,
    required String uid,
    required String size,
    @Default("") String name,
    @Default([]) List<int> type,
    @Default([]) List<String> modules,
    @Default([]) List<String> like,
    @Default([]) List<String> dislike,
    @Default(0) int downloads,
  }) = _RemoteDocModel;

  String get ext => name.split('.').last;
  String get onlyName => name.replaceAll(".$ext", "");

  factory RemoteDocModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteDocModelFromJson(json);
}
