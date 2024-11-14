import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../repositories/shared_repositories.dart';

class GetSharedFile implements UseCase<RemoteDocModel, String> {
  final SharedRepository _sharedRepository = serviceLocator<SharedRepository>();

  @override
  Future<Either<Failure, RemoteDocModel>> call(String id) async {
    return await _sharedRepository.getSharedFile(id);
  }
}
