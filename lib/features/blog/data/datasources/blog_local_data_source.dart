import 'package:blog_app/features/blog/data/model/blog_dto.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  Future<void> uploadLocalBlogs({required List<BlogDto> blogs});
  List<BlogDto> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogDto> loadBlogs() {
    return box.values
        .map((e) => BlogDto.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> uploadLocalBlogs({required List<BlogDto> blogs}) async {
    await box.clear();

    final Map<String, dynamic> blogMap = {
      for (int i = 0; i < blogs.length; i++) i.toString(): blogs[i].toJson(),
    };

    await box.putAll(blogMap);
  }
}
