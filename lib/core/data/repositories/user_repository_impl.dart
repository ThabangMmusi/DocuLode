import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/error/exceptions.dart';
import 'package:its_shared/core/error/failures.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../source/user_data_source.dart';



class UserRepositoryImpl implements UserRepository {
final UserDataSource _dataSource;

  UserRepositoryImpl({required UserDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      return right(await _dataSource.getCurrentUser());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
