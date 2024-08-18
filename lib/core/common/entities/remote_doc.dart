class RemoteDoc {
  final String? id;
  final String name;
  final List<int>? types;
  final String url;
  final List<String>? modules;
  final DateTime? uploaded;
  final String uid;
  final List<String>? like;
  final List<String>? dislike;

  final int? downloads;
  final String size;
  const RemoteDoc({
    this.id,
    this.name = "",
    this.types,
    this.modules,
    this.like,
    this.dislike,
    this.downloads,
    this.uploaded,
    this.url = "",
    this.uid = "",
    this.size = "",
  });
}
