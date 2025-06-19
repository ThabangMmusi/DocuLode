import 'package:doculode/core/index.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/data/models/src/app_user/app_user.dart';

import 'package:doculode/core/domain/entities/entities.dart';

abstract interface class AuthDataSource {
  Stream<AuthUser?> get authUserStream;
  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final DatabaseService _firebaseService;

  AuthDataSourceImpl({required DatabaseService firebaseService})
      : _firebaseService = firebaseService;

  @override
  Stream<AuthUser?> get authUserStream {
    try {
      // Use the new onUserChangedWithInitial to always emit the current user immediately
      // return _firebaseService.onUserChangedWithInitial.map((firebaseUser) {
      //   if (firebaseUser == null) return null;
      //   return firebaseUser.toEntity();
      // });
      // return null;
      return _firebaseService.onUserChanged.map((firebaseUser) {
        if (firebaseUser == null) return null;
        final appUser = firebaseUser as AppUser;
        return AuthUser(
          id: appUser.id,
          names: appUser.names,
          surname: appUser.surname,
          email: appUser.email,
          photoUrl: appUser.photoUrl,
          year: appUser.year,
          semester: appUser.semester,
          course: appUser.course,
          modules: appUser.modules,
          type: appUser.type,
          token: appUser.token,
          refreshToken: appUser.refreshToken,
        );
      });
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
