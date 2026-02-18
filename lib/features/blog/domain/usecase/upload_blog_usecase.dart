import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository repository;

  UploadBlogUsecase(this.repository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return repository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final Uint8List image;
  final List<String> topics;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
