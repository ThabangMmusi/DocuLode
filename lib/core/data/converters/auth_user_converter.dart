import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/domain/entities/entities.dart';

extension AuthUserConverter on AppUser {
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      names: names,
      surname: surname,
      email: email,
      photoUrl: photoUrl,
      year: year,
      semester: semester,
      course: course,
      modules: modules,
      type: type,
      token: token,
      refreshToken: refreshToken,
    );
  }
}

// extension AuthUserEntityMapper on AuthUser {
//   AppUser toModel() {
//     return AppUser(
//       id: id,
//       names: names,
//       surname: surname,
//       email: email,
//       photoUrl: photoUrl,
//       level: level,
//       semester: semester,
//       course: course,
//       modules: modules,
//       type: type,
//       token: token,
//       refreshToken: refreshToken,
//     );
//   }
// }
