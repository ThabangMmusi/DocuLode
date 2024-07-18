import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
@JsonSerializable(includeIfNull: false)
class AppUser with _$AppUser {
  static String kDefaultImageUrl =
      "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=80";

  const AppUser._();
  const factory AppUser({
    String? uid,
    String? names,
    String? surname,
    String? classId,
    String? type,
    String? token,
    String? refreshToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  String get getFullNames => "$surname $names";
  String get getSingleName {
    List<String> allNames = names!.split(" ");

    if (allNames.length > 1) {
      return allNames[0];
    }
    return names!;
  }
}
