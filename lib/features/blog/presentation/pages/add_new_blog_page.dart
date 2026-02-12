import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedChips = [];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add blog"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.check_mark),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: AppPallete.borderColor,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  dashPattern: [10, 5],
                  radius: Radius.circular(16),
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.folder, size: 40),
                      SizedBox(height: 15),
                      Text("Select your image", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      [
                            "Programming",
                            "Technology",
                            "Entertainment",
                            "Business",
                            "Educational",
                            "News",
                          ]
                          .map(
                            (label) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedChips.contains(label)) {
                                      selectedChips.remove(label);
                                    } else {
                                      selectedChips.add(label);
                                    }
                                  });
                                },
                                child: Chip(
                                  label: Text(
                                    label,
                                    style: TextStyle(
                                      color: AppPallete.whiteColor,
                                    ),
                                  ),
                                  color: selectedChips.contains(label)
                                      ? WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: selectedChips.contains(label)
                                      ? null
                                      : BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(height: 16),
              BlogEditor(blogController: titleController, hint: "Blog Title"),
              SizedBox(height: 10),
              BlogEditor(
                blogController: contentController,
                hint: "Blog Content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
