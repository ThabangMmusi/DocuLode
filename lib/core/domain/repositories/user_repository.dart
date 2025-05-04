import 'package:fpdart/fpdart.dart';
import '../../core.dart';
import '../entities/auth_user.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthUser?>> getCurrentUser();
  // Add other shared user-related methods here
}