import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/data/converters/converters.dart';
import 'package:doculode/core/domain/entities/auth_user.dart';

import 'package:doculode/services/services.dart';
import '../../core.dart';

abstract class UserDataSource {
  Future<AppUser?> getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  final DatabaseService _databaseService;

  UserDataSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final firebaseUser = _databaseService.currentUser;
      if (firebaseUser == null) return null;
      return firebaseUser.toEntity();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
