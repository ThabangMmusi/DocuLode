import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:its_shared/core/common/models/src/module_model/module_model.dart';

class ModuleConverter implements JsonConverter<ModuleModel, String> {
  const ModuleConverter();

  @override
  ModuleModel fromJson(String id) => ModuleModel(id: id);

  @override
  String toJson(ModuleModel module) => module.id;
}
