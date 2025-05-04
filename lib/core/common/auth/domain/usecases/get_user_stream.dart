import '../../../../domain/entities/entities.dart';
import '../repositories/auth_repository.dart';

class GetAuthUserStream {
  final AuthRepository _repository;

  GetAuthUserStream({required AuthRepository repository})
      : _repository = repository;

  Stream<AuthUser?> call() {
    return _repository.authUserStream;
  }
}
