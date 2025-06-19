import 'package:doculode/core/index.dart';
import 'package:doculode/features/sign_in/domain/repositories/sign_in_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class VerifyOtpUseCase implements UseCase<void, VerifyOtpParams> {
  final SignInRepository _repository;

  VerifyOtpUseCase({required SignInRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
    return await _repository.verifyOtp(email: params.email, otp: params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;

  const VerifyOtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
