import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models.dart';

part 'module_manager.freezed.dart';
part 'module_manager.g.dart';

@freezed
sealed class ModuleManager  with _$ModuleManager {
  const factory ModuleManager({
    List<ModuleModel>? modules,
    List<String>? predecessors,
  }) = _ModuleManager;

  factory ModuleManager.fromJson(Map<String, dynamic> json) =>
      _$ModuleManagerFromJson(json);
}
