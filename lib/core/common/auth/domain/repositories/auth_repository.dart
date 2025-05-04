import 'package:fpdart/fpdart.dart';

import '../../../../core.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/repositories/user_repository.dart';

abstract class AuthRepository extends UserRepository {
  Stream<AuthUser?> get authUserStream;
  Future<Either<Failure, void>> signOut();
}
