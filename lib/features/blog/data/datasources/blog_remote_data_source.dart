import 'dart:typed_data';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/blog/data/model/blog_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogDto> uploadBlog(BlogDto blog);
  Future<String> uploadThumbnail({
    required Uint8List image,
    required String id,
  });
  Future<List<BlogDto>> getAllBlogs();
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final SupabaseClient supabaseclient;

  BlogRemoteDataSourceImpl(this.supabaseclient);

  @override
  Future<BlogDto> uploadBlog(BlogDto blog) async {
    try {
      final uploadedBlog = await supabaseclient
          .from('blogs')
          .insert(blog.toJson())
          .select();
      return BlogDto.fromJson(uploadedBlog.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadThumbnail({
    required Uint8List image,
    required String id,
  }) async {
    try {
      await supabaseclient.storage
          .from(AppSecrets.storageBucketThumbnailName)
          .uploadBinary(
            id,
            image,
            fileOptions: const FileOptions(contentType: 'image/png'),
          );
      return supabaseclient.storage
          .from(AppSecrets.storageBucketThumbnailName)
          .getPublicUrl(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogDto>> getAllBlogs() async {
    try {
      final blogs = await supabaseclient
          .from('blogs')
          .select('*, profiles(name)');
      return blogs.map((blog) => BlogDto.fromJson(blog)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
