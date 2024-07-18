import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:its_shared/core/core.dart';

part 'doc_model.freezed.dart';
part 'doc_model.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class DocModel extends Doc with _$DocModel {
  const factory DocModel({
    required String id,
    required String type,
    required String ext,
    required String name,
    required String module,
    required String uploadDate,
    required String uploadedBy,
    @Default([]) List<String> like,
    @Default([]) List<String> dislike,
    @Default(0) int downloads,
  }) = _DocModel;

  factory DocModel.fromJson(Map<String, dynamic> json) =>
      _$DocModelFromJson(json);
}
