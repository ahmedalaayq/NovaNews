import 'package:flutter/material.dart' hide SearchController;
import 'package:nova_news/Features/home/repos/news_repository.dart';
import 'package:nova_news/core/datasource/remote/api_service.dart';
import 'package:provider/provider.dart';

import '../controller/search_controller.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> SearchController(
          NewsRepository(
            apiService: ApiService()
          ),
        ),
        child: SafeArea(child: SearchViewBody()));
  }
}
