import '../../core.dart';
import '../../data/models/models.dart';

class RemoteDoc {
  final String? id;
  final String name;
  final UploadCategory? type;
  final String url;
  final List<ModuleModel>? modules;
  final DateTime? uploaded;
  final String uid;
  final List<String>? like;
  final List<String>? dislike;
  final AccessType access;

  final int? downloads;
  final String size;
  const RemoteDoc({
    this.id,
    this.name = "",
    this.type,
    this.modules,
    this.like,
    this.dislike,
    this.downloads,
    this.uploaded,
    this.url = "",
    this.uid = "",
    this.size = "",
    this.access = AccessType.unpublished,
  });
}
