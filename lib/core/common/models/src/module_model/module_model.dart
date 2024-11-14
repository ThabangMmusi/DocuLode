// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:its_shared/core/common/entities/src/module.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_model.freezed.dart';
part 'module_model.g.dart';

@freezed
class ModuleModel extends Module with _$ModuleModel {
  // const ModuleModel._();
  const factory ModuleModel({
    required String id,
    @JsonKey(name: 'lvl') int? level,
    @JsonKey(name: 'sem') int? semester,
    String? name,
  }) = _ModuleModel;

  factory ModuleModel.fromModule(Module module) => ModuleModel(
        id: module.id,
        level: module.level,
        semester: module.semester,
        name: module.name,
      );

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
}
