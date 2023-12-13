// main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/choice/choice_page.dart';
import 'package:kondate_app/pages/recipe/recipe_page.dart';
import 'package:kondate_app/providers/current_page_provider.dart';

// メインのページ
class MainPage extends ConsumerWidget {
  const MainPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在のページのインデックスと編集モードの状態を取得
    final currentPageIndex = ref.watch(currentPageNotifierProvider);

    // ページのナビゲーションアイテム
    final List<PageNavigationDestination> destinations = [
      const PageNavigationDestination(
        selectedIcon: Icon(Icons.shopping_basket),
        icon: Icon(Icons.shopping_basket_outlined),
        label: 'Choice',
      ),
      const PageNavigationDestination(
        selectedIcon: Icon(Icons.restaurant_menu),
        icon: Icon(Icons.restaurant_menu_outlined),
        label: 'My Recipes',
      ),
      const PageNavigationDestination(
        selectedIcon: Icon(Icons.settings),
        icon: Icon(Icons.settings),
        label: 'Setting',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(pageTitles[currentPageIndex]),
      ),
      body: <Widget>[
        // 各ページのコンテナを表示
        const PageContainer(page: ChoicePage()),
        const PageContainer(page: RecipePage()),
        const PageContainer(page: Text('setting')),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        // ナビゲーションアイテムの一覧
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          final notifier = ref.read(currentPageNotifierProvider.notifier);
          notifier.changePage(index);
        },
        destinations: destinations.map((destination) {
          return NavigationDestination(
            selectedIcon: destination.selectedIcon,
            icon: destination.icon,
            label: destination.label,
          );
        }).toList(),
      ),
    );
  }
}

// 各ページのコンテンツをラップするコンテナ
class PageContainer extends StatelessWidget {
  const PageContainer({required this.page, Key? key}) : super(key: key);

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: page,
    );
  }
}

// ページのナビゲーションアイテムを表すクラス
class PageNavigationDestination {
  const PageNavigationDestination({
    required this.selectedIcon,
    required this.icon,
    required this.label,
  });

  final Icon selectedIcon;
  final Icon icon;
  final String label;
}
