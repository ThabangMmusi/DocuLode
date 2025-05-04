
import 'package:its_shared/core/data/models/models.dart';
import 'package:its_shared/core/domain/entities/entities.dart';

extension AuthUserConverter on AppUser {
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      names: names,
      surname: surname,
      email: email,
      photoUrl: photoUrl,
      level: level,
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