import 'package:doculode/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart'; // Your AuthRepository interface

class RequestOtpUseCase implements UseCase<void, String> {
  final SignInRepository _repository;

  RequestOtpUseCase({required SignInRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await _repository.requestOtp(email);
  }
}
