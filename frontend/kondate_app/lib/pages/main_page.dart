import 'package:flutter/material.dart';
import 'package:kondate_app/pages/choice_page.dart';
import 'package:kondate_app/pages/menu_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  final List<String> pageTitles = [
    'Choice!',
    'Menu!',
    'Setting',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pageTitles[currentPageIndex],
        ),
      ),
      body: <Widget>[
        const PageContainer(page: ChoicePage()),
        const PageContainer(page:MenuPage()),
        const PageContainer(page: Text('setting')),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_basket),
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Choice!',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.restaurant_menu),
            icon: Icon(Icons.restaurant_menu_outlined),
            label: 'Menu!',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

class PageContainer extends StatelessWidget {
  const PageContainer({required this.page, super.key});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: page,
    );
  }
}
