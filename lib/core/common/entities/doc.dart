class Doc {
  final String id;
  final String type;
  final String ext;
  final String name;
  final String module;
  final String uploadDate;
  final String uploadedBy;
  final List<String> like;
  final List<String> dislike;
  final int downloads;
  const Doc({
    required this.id,
    required this.type,
    required this.ext,
    required this.name,
    required this.module,
    required this.uploadDate,
    required this.uploadedBy,
    required this.like,
    required this.dislike,
    required this.downloads,
  });
}
