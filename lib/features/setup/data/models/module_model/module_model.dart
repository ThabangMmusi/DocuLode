import 'package:flutter/foundation.dart';
import 'package:its_shared/features/setup/domain/entities/module.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_model.freezed.dart';
part 'module_model.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class ModuleModel extends Module with _$ModuleModel {
  // const ModuleModel._();
  const factory ModuleModel({
    String? id,
    required int level,
    required String name,
    required List<String> courses,
  }) = _ModuleModel;

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
}
