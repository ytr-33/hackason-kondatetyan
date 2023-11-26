// main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/choice_page.dart';
import 'package:kondate_app/pages/menu_page.dart';

// 現在のページのインデックスを管理するProvider
final currentPageIndexProvider = StateProvider<int>((ref) => 0);

// 編集モードの状態を管理するProvider
final editModeProvider = StateProvider<bool>((ref) => false);

// メインのページ
class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在のページのインデックスと編集モードの状態を取得
    final int currentPageIndex = ref.watch(currentPageIndexProvider);
    final bool editMode = ref.watch(editModeProvider);

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
        label: 'Menu',
      ),
      const PageNavigationDestination(
        selectedIcon: Icon(Icons.settings),
        icon: Icon(Icons.settings),
        label: 'Setting',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageTitles[currentPageIndex]),
        actions: [
          // 編集モードのスイッチ
          Switch(
            value: editMode,
            activeColor: Colors.orange,
            onChanged: (value) {
              ref.read(editModeProvider.notifier).state = value;
            },
          ),
        ],
      ),
      body: <Widget>[
        // 各ページのコンテナを表示
        const PageContainer(page: ChoicePage()),
        const PageContainer(page: MenuPage()),
        const PageContainer(page: Text('setting')),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        // ナビゲーションアイテムの一覧
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          ref.read(currentPageIndexProvider.notifier).state = index;
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
