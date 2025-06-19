import 'package:doculode/core/index.dart';

import 'package:fpdart/fpdart.dart';

import '../repositories/sign_in_repository.dart';

class ResendOtpUseCase implements UseCase<void, String> {
  final SignInRepository _repository;

  ResendOtpUseCase({required SignInRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await _repository.resendOtp(email);
  }
}
