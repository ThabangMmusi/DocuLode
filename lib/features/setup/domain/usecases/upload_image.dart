import 'package:doculode/core/index.dart';
import 'package:doculode/features/setup/data/data.dart';

import 'dart:io';

import 'package:fpdart/fpdart.dart';

class UploadImageUseCase implements UseCase<String, File> {
  final SetupRepository _repository;

  UploadImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(File imageFile) async {
    return await _repository.uploadImage(imageFile);
  }
}
