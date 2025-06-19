import 'package:doculode/core/index.dart';
import 'package:doculode/features/profile_setup/data/data.dart';

import 'dart:io';

import 'package:fpdart/fpdart.dart';

class UploadProfileImageUseCase implements UseCase<String, File> {
  final ProfileSetupRepository repository;

  UploadProfileImageUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(File imageFile) async {
    return await repository.uploadProfileImage(imageFile);
  }
}
