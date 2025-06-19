import 'package:doculode/core/index.dart';
import 'package:doculode/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:doculode/core/error/failures.dart';
import 'package:doculode/features/sign_in/data/datasources/sign_in_data_source.dart';
import 'package:fpdart/fpdart.dart'; // Data Source Interface & Exceptions
// TODO: Import a NetworkInfo utility if you have one to check connectivity
//

class SignInRepositoryImpl implements SignInRepository {
  final SignInDataSource dataSource;
  // final NetworkInfo networkInfo; // TODO: Inject NetworkInfo

  SignInRepositoryImpl({
    required this.dataSource,
    // required this.networkInfo, // TODO
  });

  // Helper to derive email from email, assuming this logic is consistent
  String _deriveEmail(String email) {
    return email;
  }

  @override
  Future<Either<Failure, void>> requestOtp(String email) async {
    // TODO: if (!await networkInfo.isConnected) { return Left(NetworkFailure()); }
    try {
      final derivedEmail = _deriveEmail(email);
      await dataSource.requestOtpApi(derivedEmail);
      return const Right(unit); // fpdart uses 'unit' for void success
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      // If remoteDataSource throws this for network issues
      return Left(NetworkFailure());
    } catch (e) {
      // Catch-all for unexpected errors
      return Left(
          ServerFailure("An unexpected error occurred while requesting OTP."));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    // TODO: if (!await networkInfo.isConnected) { return Left(NetworkFailure()); }
    try {
      final derivedEmail = _deriveEmail(email);
      await dataSource.verifyOtpApi(derivedEmail, otp);
      return const Right(unit); // fpdart uses 'unit' for void success
    } on InvalidOtpException catch (e) {
      // Specific exception for invalid OTP from data source
      return Left(
          ValidationFailure(e.message)); // Map to domain ValidationFailure
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure(
          "An unexpected error occurred during OTP verification."));
    }
  }

  @override
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
  Future<Either<Failure, void>> resendOtp(String email) async {
    // TODO: if (!await networkInfo.isConnected) { return Left(NetworkFailure()); }
    try {
      final derivedEmail = _deriveEmail(email);
      await dataSource.resendOtpApi(derivedEmail);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(
          ServerFailure("An unexpected error occurred while resending OTP."));
    }
  }
}
