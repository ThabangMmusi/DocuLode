import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/common/auth/data/source/source.dart';
import 'package:its_shared/core/domain/repositories/user_repository.dart';
import 'package:its_shared/core/error/exceptions.dart';
import 'package:its_shared/core/error/failures.dart';

import '../../../../domain/entities/entities.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final UserRepository _userRepository; // Get user data from here

  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required UserRepository userRepository,
  })  : _authDataSource = authDataSource,
        _userRepository = userRepository;

  @override
  Stream<AuthUser?> get authUserStream => _authDataSource.authUserStream;

  @override
  Future<Either<Failure, void>> signOut() {
    try {
      unawaited(_authDataSource.signOut());
      return Future.value(right(null));
    } on ServerException catch (e) {
      return Future.value(left(Failure(e.message)));
    }
  }

  // Get user-related data from UserRepository
  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() => 
      _userRepository.getCurrentUser();
}