import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';

import '../../../../core/domain/entities/module.dart';
import '../repositories/upload_edit_repositories.dart';

class GetSortedModules implements UseCase<List<Module>, NoParams> {
  final UploadEditRepository _setUpRepository =
      serviceLocator<UploadEditRepository>();

  @override
  Future<Either<Failure, List<Module>>> call(NoParams params) async {
    return await _setUpRepository.getSortedModules();
  }
}
