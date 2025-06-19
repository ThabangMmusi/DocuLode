import 'package:fpdart/fpdart.dart';

import 'package:doculode/core/core.dart';
import 'package:doculode/features/uploads/domain/repositories/uploads_repositories.dart';

class GetUploads implements UseCase<FetchedRemoteDocs, NoParams> {
  final UploadsRepository uploadsRepository;

  GetUploads(this.uploadsRepository);

  @override
  Future<Either<Failure, FetchedRemoteDocs>> call(NoParams params) async {
    return await uploadsRepository.getUploads();
  }
}
