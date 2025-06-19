import 'package:doculode/core/error/failures.dart';
import 'package:fpdart/fpdart.dart'; // Adjust path

abstract class SignInRepository {
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, void>> signInWithMicrosoft();
}
