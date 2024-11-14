import 'package:fpdart/fpdart.dart';
import 'package:its_shared/injection_container.dart';
import '../../../../core/core.dart';
import '../repositories/shared_repositories.dart';

class DownloadFile implements UseCase<void, DownloadFileParams> {
  final SharedRepository uploadEditRepository =
      serviceLocator<SharedRepository>();

  @override
  Future<Either<Failure, void>> call(DownloadFileParams params) async {
    return await uploadEditRepository.downloadFile(
      id: params.id,
      url: params.url,
    );
  }
}

class DownloadFileParams {
  final String id;
  final String url;

  DownloadFileParams({
    required this.id,
    required this.url,
  });
}
