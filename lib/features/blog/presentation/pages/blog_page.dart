import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final List<Color> palette = [
    Color.fromRGBO(251, 109, 169, 1), // pink
    Color.fromRGBO(255, 159, 124, 1), // peach
    Color.fromRGBO(254, 205, 86, 1), // yellow
    Color.fromRGBO(102, 204, 255, 1), // sky blue
    Color.fromRGBO(102, 255, 178, 1), // mint green
    Color.fromRGBO(255, 102, 102, 1), // coral red
    Color.fromRGBO(153, 102, 255, 1), // lavender
    Color.fromRGBO(255, 204, 102, 1), // soft orange
    Color.fromRGBO(102, 255, 255, 1), // cyan
    Color.fromRGBO(255, 153, 255, 1), // magenta
    Color.fromRGBO(153, 255, 102, 1), // light green
    Color.fromRGBO(255, 102, 204, 1), // hot pink
  ];

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: palette[index % palette.length],
                );
              },
            );
          }
          return Center(
            child: Text(
              "Something went wrong, please try again later!",
              style: TextStyle(color: AppPallete.errorColor),
            ),
          );
        },
      ),
    );
  }
}
