import 'package:doculode/app/config/index.dart';

import 'package:fpdart/fpdart.dart';

import 'package:doculode/core/core.dart';
import '../repositories/upload_edit_repositories.dart';

class UploadUpdate implements UseCase<void, UpdateFileParams> {
  final UploadEditRepository uploadEditRepository = sl<UploadEditRepository>();

  @override
  Future<Either<Failure, void>> call(UpdateFileParams params) async {
    return await uploadEditRepository.updateDoc(
      id: params.id,
      name: params.name,
      type: params.type,
      access: params.access,
      modules: params.modules,
    );
  }
}

class UpdateFileParams {
  final String id;
  final String name;
  final int type;
  final int access;
  final List<String> modules;

  UpdateFileParams({
    required this.id,
    required this.name,
    required this.access,
    required this.type,
    required this.modules,
  });
}
