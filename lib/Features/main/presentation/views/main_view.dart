import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:nova_news/Features/bookmark/presentation/views/bookmark_view.dart';
import 'package:nova_news/Features/home/presentation/views/home_view.dart';
import 'package:nova_news/Features/search/views/search_view.dart';

import '../../../profile/presentation/views/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  final List<Widget> _views = const [
    HomeView(),
    SearchView(),
    BookmarkView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        animationDuration: Duration(milliseconds: 500),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(IconlyLight.home, size: 20),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.bookmark),
            label: 'Bookmark',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _views),
    );
  }
}
