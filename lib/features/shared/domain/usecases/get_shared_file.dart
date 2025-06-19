import 'package:doculode/config/index.dart';
import 'package:doculode/core/index.dart';



















import 'package:fpdart/fpdart.dart';



import '../repositories/shared_repositories.dart';

class GetSharedFile implements UseCase<RemoteDocModel, String> {
  final SharedRepository _sharedRepository = sl<SharedRepository>();

  @override
  Future<Either<Failure, RemoteDocModel>> call(String id) async {
    return await _sharedRepository.getSharedFile(id);
  }
}
