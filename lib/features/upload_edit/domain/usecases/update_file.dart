import 'package:fpdart/fpdart.dart';
import '../../../../core/core.dart';
import '../repositories/upload_edit_repositories.dart';

class UploadEdit implements UseCase<void, UpdateFileParams> {
  final UploadEditRepository uploadEditRepository;

  UploadEdit(this.uploadEditRepository);

  @override
  Future<Either<Failure, void>> call(UpdateFileParams params) async {
    return await uploadEditRepository.updateDoc(
      id: params.id,
      name: params.name,
      types: params.types,
      modules: params.modules,
    );
  }
}

class UpdateFileParams {
  final String id;
  final String name;
  final List<int> types;
  final List<String> modules;

  UpdateFileParams({
    required this.id,
    required this.name,
    required this.types,
    required this.modules,
  });
}
