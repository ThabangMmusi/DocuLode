import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:doculode/app/auth/data/data_source/source.dart';
import 'package:doculode/core/error/exceptions.dart';
import 'package:doculode/core/error/failures.dart';

import '../../../../core/data/models/src/app_user_model/app_user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  // @overrides
  Stream<AppUserModel?> get onAuthStateChanged => _authDataSource.onAuthStateChanged;

  @override
  Future<Either<Failure, void>> signOut() {
    try {
      unawaited(_authDataSource.signOut());
      return Future.value(right(null));
    } on ServerException catch (e) {
      return Future.value(left(ServerFailure(e.message)));
    }
  }

  // Get user-related data from UserRepository
  @override
  Future<Either<Failure, AppUserModel?>> getCurrentUser() async {
     try {
      return right(await _authDataSource.getCurrentUser());
    } on ServerException catch (e) {
      return Future.value(left(ServerFailure(e.message)));
    }
  }
}
