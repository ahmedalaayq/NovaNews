import 'package:flutter/material.dart';
import 'package:nova_news/Features/bookmark/presentation/views/widgets/bookmark_view_body.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Bookmarks', style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body:BookMarkViewBody(),
    );
  }
}

