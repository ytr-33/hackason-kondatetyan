import 'package:flutter/material.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/pages/add_recipe_page.dart';
import 'package:kondate_app/pages/edit_recipe_page.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/data/recipe.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    void showDeleteConfirmationDialog(String recipeName) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('確認'),
            content: Text('$recipeName を削除しますか？'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  // 削除ボタンが押されたときの処理
                  // ここでrecipeを削除するなどの処理を行う
                  Navigator.of(context).pop(); // Close the confirmation dialog
                },
                child: const Text('削除'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: menuCategories.length,
        itemBuilder: (context, categoryIndex) {
          String category = menuCategories[categoryIndex];

          // カテゴリーごとに対応するレシピを抽出
          List<Recipe> categoryRecipes =
              recipes.where((recipe) => recipe.category == category).toList();

          return ExpansionTile(
            title: Text(category),
            children: categoryRecipes.map((recipe) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(recipe.name),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // 編集アイコンが押されたときの処理
                            // ここでrecipeの編集画面に遷移する処理を行う
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditRecipePage(recipe: recipe),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // レシピ削除ボタンが押されたときの処理
                            // ここで削除の確認ダイアログを表示
                            showDeleteConfirmationDialog(recipe.name);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Add Recipe ボタンが押されたときの処理
          // レシピの追加画面に遷移
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            // 追加画面のウィジェットを返す
            return const AddRecipePage(); // このページはまだ実装されていないので、実際のアプリに合わせて実装してください
          }));
        },
      ),
    );
  }
}
