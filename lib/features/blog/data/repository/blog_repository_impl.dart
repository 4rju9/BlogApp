import 'package:uuid/uuid.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/model/blog_dto.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'dart:typed_data';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      final blogId = const Uuid().v1();
      final thumbnailUrl = await blogRemoteDataSource.uploadThumbnail(
        image: image,
        id: blogId,
      );

      BlogDto blogDto = BlogDto(
        id: blogId,
        userId: userId,
        title: title,
        content: content,
        thumbnailUrl: thumbnailUrl,
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final blog = await blogRemoteDataSource.uploadBlog(blogDto);
      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
