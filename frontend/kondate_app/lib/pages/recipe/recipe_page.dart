import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/dialogs/delete_recipe_confirmation_dialog.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/pages/recipe/add_recipe_page.dart';
import 'package:kondate_app/pages/recipe/edit_recipe_page.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/providers/recipe_provider.dart';
import 'package:kondate_app/services/api_service.dart';
import 'package:kondate_app/widgets/recipe_list_tile.dart';

class RecipePage extends ConsumerWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // レシピのリストを取得
    final recipes = ref.watch(recipeNotifierProvider);

    void showDeleteConfirmationDialog(Recipe recipe) {
      DeleteRecipeConfirmationDialog.show(context, recipe, () async {
        // APIから材料を削除
        await deleteRecipeToApi(recipe.id);
        final notifier = ref.read(recipeNotifierProvider.notifier);
        notifier.removeRecipe(recipe.id);
      });
    }

    final loopColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String category in menuCategories)
          ExpansionTile(
            title: Text(category),
            children: [
              // カテゴリに属するレシピごとにリストタイルを表示
              for (Recipe? recipe in recipes.values)
                if (recipe!.category == category)
                  // カスタムウィジェットを利用して材料のリストタイルを表示
                  RecipeListTile(
                    recipe: recipe,
                    onEditPressed: () {
                      // 編集画面に遷移
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditRecipePage(
                            recipe: recipe,
                          ),
                        ),
                      );
                    },
                    onDeletePressed: () {
                      // 削除確認ダイアログを表示
                      showDeleteConfirmationDialog(recipe);
                    },
                  )
                else if (recipe.category != category)
                  Container(),
            ],
          ),
      ],
    );

    // カスタムウィジェットとしてSpeedDialを利用
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: loopColumn,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Add Recipe ボタンが押されたときの処理
          // レシピの追加画面に遷移
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            // 追加画面のウィジェットを返す
            return const AddRecipePage(); 
          }));
        },
      ),
    );
  }
}
