import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/data/converters/converters.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../domain/entities/entities.dart';

abstract interface class AuthDataSource {
  Stream<AuthUser?> get authUserStream;
  Future< void> signOut();}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseService _firebaseService;

  AuthDataSourceImpl({required FirebaseService firebaseService}) : _firebaseService = firebaseService;

  
  @override
  Stream<AuthUser?> get authUserStream {
    try {
      return _firebaseService.onUserChanged.map((firebaseUser) {
        if (firebaseUser == null) return null;
        return firebaseUser.toEntity();
      });
    } catch (e) {
      log(e.toString());
      throw ServerException (e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      log(e.toString());
      throw ServerException (e.toString());
    }
  }
}