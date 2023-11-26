import 'package:flutter/material.dart';
import 'package:kondate_app/configs/constants.dart';

class EditIngredientPage extends StatefulWidget {
  final String ingredientName;
  final String initialCategory;

  const EditIngredientPage(
      {Key? key, required this.ingredientName, required this.initialCategory})
      : super(key: key);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  late TextEditingController _ingredientNameController;
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    // 提供された ingredientName でコントローラーを初期化
    _ingredientNameController =
        TextEditingController(text: widget.ingredientName);
    // 選択されたカテゴリーを初期化
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Ingredient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // 材料名を入力するテキストフィールド
            TextField(
              controller: _ingredientNameController,
              decoration: const InputDecoration(labelText: 'Ingredient Name'),
            ),
            const SizedBox(height: 20),
            // カテゴリーを選択するドロップダウンボタン
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: ingredientCategories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 20),
            // 保存ボタン
            ElevatedButton(
              onPressed: () {
                // 保存ボタンが押された時の処理
                _saveChanges();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    // ここに変更を保存するためのロジックを追加
    // 簡単にするため、新しい材料名とカテゴリーを印刷するだけとします
    print('新しい材料名: ${_ingredientNameController.text}');
    print('新しいカテゴリー: $_selectedCategory');
    // ここにアプリのデータ構造やデータベースで材料データを更新するためのロジックを追加できます
  }

  @override
  void dispose() {
    // ウィジェットが廃棄されたときにコントローラーを破棄
    _ingredientNameController.dispose();
    super.dispose();
  }
}
