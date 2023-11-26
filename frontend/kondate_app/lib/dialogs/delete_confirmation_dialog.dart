// lib/dialogs/delete_confirmation_dialog.dart
import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static void show(BuildContext context, String ingredientName,
      Future<void> Function() onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認'),
          content: Text('$ingredientName を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                await onConfirm(); // 非同期処理を待つ
                Navigator.of(context).pop(); // ダイアログを閉じる
              },
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }
}
