// choice_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/dialogs/delete_confirmation_dialog.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/pages/add_ingredient_page.dart';
import 'package:kondate_app/pages/edit_ingredient_page.dart';
import 'package:kondate_app/pages/result_page.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/providers/selected_ingredients_provider.dart';
import 'package:kondate_app/services/api_service.dart';
import 'package:kondate_app/widgets/custom_speed_dial.dart'; // カスタムウィジェットをインポート
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/widgets/ingredient_list_tile.dart';

// 状態に応じた処理
class ChoicePage extends ConsumerWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(ingredientNotifierProvider);
    final selectedIngredients = ref.watch(selectedIngredientsNotifierProvider);

    void showDeleteConfirmationDialog(Ingredient ingredient) {
      // ダイアログを表示し、削除が確定されたら非同期で削除
      DeleteConfirmationDialog.show(context, ingredient, () async {
        // APIから材料を削除
        await deleteIngredientToApi(ingredient.id);
        final notifier = ref.read(ingredientNotifierProvider.notifier);
        notifier.removeIngredient(ingredient.id);
      });
    }

    // RiverpodのProviderから選択された材料のリストを取得

    // 材料の選択をクリアする関数
    void clearSelection() {
      final notifier = ref.read(selectedIngredientsNotifierProvider.notifier);
      notifier.clearState();
    }

    void removeSelection(num id) {
      deleteIngredientToApi(id);
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
                for (num id in selectedIngredients)
                  Text(
                    ingredients[id]?.name ?? '',
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

    final loopColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (String category in ingredientCategories)
          ExpansionTile(
            title: Text(category),
            children: [
              // カテゴリに属する材料ごとにリストタイルを表示
              for (Ingredient? ingredient in ingredients.values)
                if (ingredient!.category == category)
                  // カスタムウィジェットを利用して材料のリストタイルを表示
                  IngredientListTile(
                    ingredient: ingredient,
                    isSelected: selectedIngredients.contains(ingredient.id),
                    onCheckboxChanged: (value) {
                      if (value == true) {
                        // チェックが入ったときの処理
                        final notifier = ref
                            .read(selectedIngredientsNotifierProvider.notifier);
                        notifier.addState(ingredient.id);
                      } else {
                        // チェックが外れたときの処理
                        final notifier = ref
                            .read(selectedIngredientsNotifierProvider.notifier);
                        notifier.removeState(ingredient.id);
                      }
                    },
                    onEditPressed: () {
                      // 編集画面に遷移
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditIngredientPage(
                            ingredient: ingredient,),
                        ),
                      );
                    },
                    onDeletePressed: () {
                      // 削除確認ダイアログを表示
                      showDeleteConfirmationDialog(ingredient);
                    },
                  )
                else if (ingredient.category != category)
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
            return AddIngredientPage();
          }));
        },
        // チェックをクリアするボタン
        onClearCheckTap: clearSelection,
      ),
    );
  }
}
