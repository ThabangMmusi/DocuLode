import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:fpdart/fpdart.dart';
import 'package:its_shared/features/upload_progress/domain/domain.dart';

import '../../../../core/core.dart';

class UploadFile {
  final UploadFileRepository uploadFileRepository;

  UploadFile(this.uploadFileRepository);

  Stream<Either<Failure, double>> upload(LocalDoc file) async* {
    yield* uploadFileRepository.uploadFile(file);
  }

  // void call(UploadBlogParams params) async {
  //   // Perform validation or any additional logic here before uploading
  //   // You can emit events or updates using _controller
  //   _controller.add(await blogRepository.uploadBlog(
  //     image: params.image,
  //     title: params.title,
  //     content: params.content,
  //     posterId: params.posterId,
  //     topics: params.topics,
  //   ));
  // }

  // void dispose() {
  //   _controller.close();
  // }
}

class UploadFileParams {
  final String? path;
  final String name;
  final XFile? asset;

  UploadFileParams({
    required this.path,
    required this.name,
    required this.asset,
  });
}
