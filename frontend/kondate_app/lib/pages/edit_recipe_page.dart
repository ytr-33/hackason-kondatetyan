import 'package:flutter/material.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/recipe.dart';

class EditRecipePage extends StatefulWidget {
  final Recipe recipe;

  const EditRecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  late TextEditingController _recipeNameController;
  late TextEditingController _ingredientsController;
  String _selectedCategory = menuCategories[0];
  late TextEditingController _procedureController;

  @override
  void initState() {
    super.initState();
    // 提供されたレシピデータでコントローラーを初期化
    _recipeNameController = TextEditingController(text: widget.recipe.name);
    _ingredientsController =
        TextEditingController(text: widget.recipe.ingredients.toString());
    _selectedCategory = widget.recipe.category;
    _procedureController =
        TextEditingController(text: widget.recipe.procedure.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // 新しいレシピ名を入力するテキストフィールド
            TextField(
              controller: _recipeNameController,
              decoration: const InputDecoration(labelText: 'レシピ名'),
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
              items:
                  menuCategories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),

            const SizedBox(height: 20),
            // 材料を入力するテキストフィールド（JSON形式）
            TextFormField(
              controller: _ingredientsController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: '材料'),
            ),
            const SizedBox(height: 20),
            // 手順を入力するテキストフィールド（JSON形式）
            TextFormField(
              controller: _procedureController,
              maxLines: 10,
              decoration: const InputDecoration(labelText: '手順'),
            ),
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
    // 簡単にするため、新しいレシピデータを印刷するだけとします
    print('New Recipe Name: ${_recipeNameController.text}');
    print('New Category: $_selectedCategory');
    print('New Ingredients: ${_ingredientsController.text}');
    // ここにアプリのデータ構造やデータベースでレシピデータを更新するためのロジックを追加できます
  }

  @override
  void dispose() {
    // ウィジェットが廃棄されたときにコントローラーを破棄
    _recipeNameController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }
}
