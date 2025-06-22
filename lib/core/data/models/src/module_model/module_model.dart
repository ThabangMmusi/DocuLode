import 'package:doculode/core/domain/entities/module.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'module_model.freezed.dart';
part 'module_model.g.dart';

@freezed
sealed class ModuleModel extends Module with _$ModuleModel {
  ModuleModel._() : super(id: "");
  factory ModuleModel({
    required String id,
    @JsonKey(name: "module_id") String? moduleId,
    @JsonKey(name: "module_name") String? name,
  }) = _ModuleModel;

  // factory ModuleModel.fromModule(Module module) => ModuleModel(
  //       id: module.id,
  //       year: module.year,
  //       semester: module.semester,
  //       name: module.name,
  //     );

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
}
