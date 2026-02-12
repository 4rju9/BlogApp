// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController blogController;
  final String hint;

  const BlogEditor({Key? key, required this.blogController, required this.hint})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: blogController,
      decoration: InputDecoration(hintText: hint),
      maxLines: null,
    );
  }
}
