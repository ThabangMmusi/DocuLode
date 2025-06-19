import 'entities.dart';

class AuthUser {
  final String? id;
  final String? names;
  final String? surname;
  final String? email;
  final String? photoUrl;
  final int? year;
  final int? semester;
  final Course? course;
  final List<Module>? modules;
  final String? type;
  final String? token;
  final String? refreshToken;

  AuthUser({
    this.id,
    this.names,
    this.surname,
    this.email,
    this.photoUrl,
    this.year,
    this.semester,
    this.course,
    this.modules,
    this.type,
    this.token,
    this.refreshToken,
  });
}
