import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  bool isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = isColorDark(color) ? Colors.white : Colors.black;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 200),
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (label) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: Chip(
                              color: WidgetStatePropertyAll(textColor),
                              label: Text(
                                label,
                                style: TextStyle(fontSize: 12, color: color),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            Text(
              "Estimated Reading Time: ${calculateReadingTime(blog.content)} min",
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
