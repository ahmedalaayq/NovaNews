import 'package:flutter/material.dart';
import 'package:nova_news/Features/bookmark/presentation/views/bookmark_view.dart';
import 'package:nova_news/Features/home/presentation/views/home_view.dart';
import 'package:nova_news/Features/search/views/search_view.dart';

import '../../../profile/presentation/views/profile_view.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:nova_news/Features/home/repos/news_repository.dart';
import 'package:nova_news/core/datasource/remote/api_service.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  late final HomeController homeController;

  final List<Widget> _views = const [
    HomeView(),
    SearchView(),
    BookmarkView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();

    homeController = HomeController(
      newsRepo: NewsRepository(
        apiService: ApiService(),
      ),
    );

    homeController.init();
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeController,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(IconBold.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(IconBold.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(IconBold.bookmark),
              label: 'Bookmark',
            ),
            NavigationDestination(
              icon: Icon(IconBold.profile),
              label: 'Profile',
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _views,
        ),
      ),
    );
  }
}