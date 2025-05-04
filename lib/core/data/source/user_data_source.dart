import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/data/converters/converters.dart';
import 'package:its_shared/core/domain/entities/auth_user.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../core.dart';

abstract class UserDataSource {
  Future<AuthUser?> getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseService _firebaseService;

  UserDataSourceImpl({required FirebaseService firebaseService}) : _firebaseService = firebaseService;


  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseService.currentUser;
      if (firebaseUser == null) return null;
      return firebaseUser.toEntity();
    } catch (e) {
      log(e.toString());
      throw ServerException (e.toString());
    }
  }

}