import 'package:doculode/core/index.dart';
import 'package:doculode/features/azure_sign_in/domain/repositories/sign_in_repository.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/features/azure_sign_in/data/datasources/sign_in_data_source.dart';
import 'package:fpdart/fpdart.dart'; // Data Source Interface & Exceptions

class SignInRepositoryImpl implements SignInRepository {
  final SignInDataSource dataSource;

  SignInRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final isLoggedIn = await dataSource.isUserLoggedIn();
      return Right(isLoggedIn);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure("An unexpected error occurred while checking user login status."));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithMicrosoft() async {
    try {
      await dataSource.signInWithMicrosoftApi();
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

}
