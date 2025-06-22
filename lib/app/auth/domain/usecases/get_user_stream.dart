import '../../../../core/domain/entities/entities.dart';
import '../repositories/auth_repository.dart';

class GetAuthUserStream {
  final AuthRepository _repository;

  GetAuthUserStream(this._repository);

  Stream<AppUser?> call() {
    return _repository.onAuthStateChanged;
  }
}
