import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../repositories/uploads_repositories.dart';

class GetUploads implements UseCase<FetchedRemoteDocs, NoParams> {
  final UploadsRepository uploadsRepository;

  GetUploads(this.uploadsRepository);

  @override
  Future<Either<Failure, FetchedRemoteDocs>> call(NoParams params) async {
    return await uploadsRepository.getUploads();
  }
}
