import 'package:doculode/core/domain/entities/auth_user.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Stream<AppUser?> get onAuthStateChanged;
  Future<Either<Failure, void>> signOut();
}
