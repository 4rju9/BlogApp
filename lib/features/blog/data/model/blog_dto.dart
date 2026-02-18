import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogDto extends Blog {
  BlogDto({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.thumbnailUrl,
    required super.topics,
    required super.updatedAt,
    super.userName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'thumbnail_url': thumbnailUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogDto.fromJson(Map<String, dynamic> map) {
    return BlogDto(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      thumbnailUrl: map['thumbnail_url'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      userName: map['profiles']?['name'] ?? 'Unknown',
    );
  }
}
