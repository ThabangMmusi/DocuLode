import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/domain/entities/auth_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

class CourseConverter implements JsonConverter<CourseModel, String> {
  const CourseConverter();

  @override
  CourseModel fromJson(String id) => CourseModel(id: id);

  @override
  String toJson(CourseModel module) => module.id;
}

@freezed
sealed class AppUserModel extends AppUser with _$AppUserModel {
  static String kDefaultImageUrl =
      "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=80";

  AppUserModel._() : super(id: "");
  factory AppUserModel({
    required String id,
    String? names,
    String? surname,
    String? email,
    String? photoUrl,
    int? year,
    int? semester,
    @CourseConverter() CourseModel? course,
    @ModuleConverter() List<ModuleModel>? modules,
  }) = _AppUser;

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
