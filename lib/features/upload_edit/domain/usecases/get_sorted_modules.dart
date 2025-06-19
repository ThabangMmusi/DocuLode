import 'package:doculode/config/index.dart';
import 'package:doculode/core/index.dart';



















import 'package:fpdart/fpdart.dart';



import '../../../../core/domain/entities/module.dart';
import '../repositories/upload_edit_repositories.dart';

class GetSortedModules implements UseCase<List<Module>, NoParams> {
  final UploadEditRepository _setUpRepository = sl<UploadEditRepository>();

  @override
  Future<Either<Failure, List<Module>>> call(NoParams params) async {
    return await _setUpRepository.getSortedModules();
  }
}
