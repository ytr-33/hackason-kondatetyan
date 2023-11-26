// lib/dialogs/selected_ingredients_dialog.dart
import 'package:flutter/material.dart';

class SelectedIngredientsDialog {
  static void show(BuildContext context, List<String> selectedIngredients) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Ingredients'),
          content: Column(
            children: [
              // 材料が選択されていない場合のメッセージ
              if (selectedIngredients.isEmpty)
                const Text('何も選択されていません。')
              else
                // 選択された材料を表示
                ...selectedIngredients.map((ingredient) => Text(ingredient)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
