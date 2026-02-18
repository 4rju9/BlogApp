class Blog {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String thumbnailUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final String? userName;

  Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.thumbnailUrl,
    required this.topics,
    required this.updatedAt,
    this.userName,
  });
}
