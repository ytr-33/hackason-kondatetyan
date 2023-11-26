// choice_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/dialogs/delete_confirmation_dialog.dart';
import 'package:kondate_app/dialogs/selected_ingredients_dialog.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/pages/add_ingredient_page.dart';
import 'package:kondate_app/pages/edit_ingredient_page.dart';
import 'package:kondate_app/pages/result_page.dart';
import 'package:kondate_app/widgets/custom_speed_dial.dart'; // カスタムウィジェットをインポート
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/data/ingredient.dart';
import 'package:kondate_app/widgets/ingredient_list_tile.dart';
import 'package:kondate_app/utils/list_extension.dart'; // リストの拡張メソッドをインポート

// RiverpodのProvider
final selectedIngredientsProvider = StateProvider<List<String>>((ref) => []);

class ChoicePage extends ConsumerWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RiverpodのProviderから選択された材料のリストを取得
    final List<String> selectedIngredients =
        ref.watch(selectedIngredientsProvider);

    // 材料の選択をクリアする関数
    void clearSelection() {
      ref.read(selectedIngredientsProvider.notifier).state = [];
    }

    // 選択された材料を表示する関数
    void showSelectedIngredients() {
      SelectedIngredientsDialog.show(context, selectedIngredients);
    }

    // 削除確認ダイアログを表示する関数
    void showDeleteConfirmationDialog(String ingredientName) {
      // ダイアログを表示し、削除が確定されたら非同期で削除
      DeleteConfirmationDialog.show(context, ingredientName, () async {
        await Future.delayed(const Duration(seconds: 3)); // 仮の非同期処理の例
        // 削除確認ダイアログで"削除"が選択されたときの処理
        ref.read(selectedIngredientsProvider.notifier).state =
            List.from(selectedIngredients)..remove(ingredientName);
      });
    }

    // カスタムウィジェットとしてSpeedDialを利用
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // カテゴリごとに展開可能なリストを表示
                  for (String category in ingredientCategories)
                    ExpansionTile(
                      title: Text(category),
                      children: [
                        // カテゴリに属する材料ごとにリストタイルを表示
                        for (Ingredient ingredient in ingredients)
                          if (ingredient.category == category)
                            // カスタムウィジェットを利用して材料のリストタイルを表示
                            IngredientListTile(
                              ingredient: ingredient,
                              isSelected:
                                  selectedIngredients.contains(ingredient.name),
                              onCheckboxChanged: (value) {
                                ref
                                    .read(selectedIngredientsProvider.notifier)
                                    .state = List.from(selectedIngredients)
                                  ..toggle(ingredient.name);
                              },
                              onEditPressed: () {
                                // 編集画面に遷移
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditIngredientPage(
                                      ingredientName: ingredient.name,
                                      initialCategory: ingredient.category,
                                    ),
                                  ),
                                );
                              },
                              onDeletePressed: () {
                                // 削除確認ダイアログを表示
                                showDeleteConfirmationDialog(ingredient.name);
                              },
                            ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      // カスタムウィジェットとして作成したSpeedDialを利用
      floatingActionButton: CustomSpeedDial(
        // メニュー取得ボタン
        onGetMenuTap: () {
          // メニュー画面に遷移
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ResultPage(selectedIngredients: selectedIngredients);
          }));
        },
        // 選択された材料を表示するボタン
        onSelectedTap: showSelectedIngredients,
        // 材料を追加するボタン
        onAddTap: () {
          // 材料追加画面に遷移
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddIngredientPage();
          }));
        },
        // チェックをクリアするボタン
        onClearCheckTap: clearSelection,
      ),
    );
  }
}
