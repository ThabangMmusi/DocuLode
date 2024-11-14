import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:its_shared/core/common/models/src/course_model/course_model.dart';
import 'package:its_shared/core/common/models/src/module_converter.dart';
import 'package:its_shared/core/common/models/src/module_model/module_model.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

class CourseConverter implements JsonConverter<CourseModel, String> {
  const CourseConverter();

  @override
  CourseModel fromJson(String id) => CourseModel(id: id);

  @override
  String toJson(CourseModel module) => module.id;
}

@freezed
class AppUser with _$AppUser {
  static String kDefaultImageUrl =
      "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=80";

  const AppUser._();
  const factory AppUser({
    String? id,
    String? names,
    String? surname,
    int? level,
    @CourseConverter() CourseModel? course,
    @ModuleConverter() List<ModuleModel>? modules,
    String? type,
    String? token,
    String? refreshToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  bool get needSetup => modules == null || modules!.isEmpty;
  String get getFullNames => "$surname $names";
  String get getSingleName {
    final allNames = names!.split(" ");

    if (allNames.length > 1) {
      return allNames[0];
    }
    return names!;
  }
}
