// lib/dialogs/delete_confirmation_dialog.dart
import 'package:flutter/material.dart';
import 'package:kondate_app/models/ingredient.dart';

class DeleteIngredientConfirmationDialog {
  static void show(BuildContext context, Ingredient ingredient,
      Future<void> Function() onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認'),
          content: Text('${ingredient.name} を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }
}
