import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecase/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
  }) : _uploadBlogUsecase = uploadBlogUsecase,
       _getAllBlogsUsecase = getAllBlogsUsecase,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase(
      UploadBlogParams(
        userId: event.userId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogsUsecase(NoParams());
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
}
