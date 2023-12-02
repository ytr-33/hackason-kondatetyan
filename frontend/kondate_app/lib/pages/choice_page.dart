/*// choice_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/dialogs/delete_confirmation_dialog.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/pages/add_ingredient_page.dart';
import 'package:kondate_app/pages/edit_ingredient_page.dart';
import 'package:kondate_app/pages/result_page.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/providers/selected_ingredients_provider.dart';
import 'package:kondate_app/widgets/custom_speed_dial.dart'; // カスタムウィジェットをインポート
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/widgets/ingredient_list_tile.dart';

// RiverpodのProvider
final selectedIngredientsProvider = StateProvider<List<String>>((ref) => []);

final container = ProviderContainer();

// 状態に応じた処理

class ChoicePage extends ConsumerWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(ingredientNotifierProvider);
    final List<int> selectedIngredients =
        ref.watch(selectedIngredientsNotifierProvider);

    void showDeleteConfirmationDialog(String ingredientName) {
      // ダイアログを表示し、削除が確定されたら非同期で削除
      DeleteConfirmationDialog.show(context, ingredientName, () async {
        await Future.delayed(const Duration(seconds: 3)); // 仮の非同期処理の例
        // 削除確認ダイアログで"削除"が選択されたときの処理
        ref.read(selectedIngredientsProvider.notifier).state =
            List.from(selectedIngredients)..remove(ingredientName);
      });
    }

    Widget ingredientsColumn = ingredients.when(
      data: (ingredients) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // カテゴリごとに展開可能なリストを表示
            for (String category in ingredientCategories)
              ExpansionTile(
                title: Text(category),
                children: [
                  // カテゴリに属する材料ごとにリストタイルを表示
                  for (Ingredient ingredient in ingredients.values)
                    if (ingredient.category == category)
                      // カスタムウィジェットを利用して材料のリストタイルを表示
                      IngredientListTile(
                        ingredient: ingredient,
                        isSelected: selectedIngredients.contains(ingredient.id),
                        onCheckboxChanged: (value) {
                          if (value == true) {
                            // チェックが入ったときの処理
                            final notifier = ref.read(
                                selectedIngredientsNotifierProvider.notifier);
                            notifier.addState(ingredient.id);
                          } else {
                            // チェックが外れたときの処理
                            final notifier = ref.read(
                                selectedIngredientsNotifierProvider.notifier);
                            notifier.removeState(ingredient.id);
                          }
                        },
                        onEditPressed: () {
                          // 編集画面に遷移
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditIngredientPage(
                                ingredientName: ingredient.name,
                                ingredientCategory: ingredient.category,
                                ingredientUnit: ingredient.unit,
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
        );
        // 成功時の処理
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
        // ロード中の処理
      },
      error: (e, s) {
        return Center(
          child: Text(e.toString()),
        );
        // エラー時の処理
      },
    );

    // RiverpodのProviderから選択された材料のリストを取得

    // 材料の選択をクリアする関数
    void clearSelection() {
      final notifier = ref.read(selectedIngredientsNotifierProvider.notifier);
      notifier.clearState();
    }

    void removeSelection(int id) {
      final notifier = ref.read(selectedIngredientsNotifierProvider.notifier);
      notifier.removeState(id);
    }

    // 選択された材料を表示する関数
    void showSelectedIngredients() {
      // 選択された材料のリストを取得
      final selectedIngredients =
          ref.watch(selectedIngredientsNotifierProvider);
      // 選択された材料のリストを表示
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('選択された材料'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int id in selectedIngredients)
                  Text(
                    ingredients
                        .when(
                          data: (ingredients) {
                            return ingredients[id]!.name;
                          },
                          loading: () => 'ロード中',
                          error: (e, s) => 'エラー',
                        )
                        .toString(),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
    }

    // 削除確認ダイアログを表示する関数

    // カスタムウィジェットとしてSpeedDialを利用
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ingredientsColumn,
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
*/