// main_page.dart
import 'package:flutter/material.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/choice_page.dart';
import 'package:kondate_app/pages/menu_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// メインのページ
class MainPage extends HookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 現在のページのインデックスと編集モードの状態を取得
    final currentPageIndex = useState(0);
    final editMode = useState(false);

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(pageTitles[currentPageIndex.value]),
        actions: [
          // 編集モードのスイッチ
          Switch(
            value: editMode.value,
            activeColor: Colors.orange,
            onChanged: (value) {
              if (value) {
                editMode.value = true;
              } else {
                editMode.value = false;
              }
              debugPrint('editMode: $value ${editMode.value}');
            },
          ),
        ],
      ),
      body: <Widget>[
        // 各ページのコンテナを表示
        const PageContainer(page: ChoicePage()),
        const PageContainer(page: MenuPage()),
        const PageContainer(page: Text('setting')),
      ][currentPageIndex.value],
      bottomNavigationBar: NavigationBar(
        // ナビゲーションアイテムの一覧
        selectedIndex: currentPageIndex.value,
        onDestinationSelected: (index) {
          currentPageIndex.value = index;
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
