import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/configs/constants.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = menuCategories[0];
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _procedureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'レシピ名'),
            ),
            const SizedBox(height: 16.0),
            // カテゴリーのドロップダウンメニュー
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: menuCategories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _ingredientsController,
              maxLines: null, // 複数行のテキスト入力を可能にする
              decoration: const InputDecoration(labelText: '材料（JSON形式）'),
            ),
            const SizedBox(height: 16.0),
            // 手順の入力エリア
            TextField(
              controller: _procedureController,
              maxLines: 10, // 複数行のテキスト入力を可能にする
              decoration: const InputDecoration(labelText: '手順'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String ingredients = _ingredientsController.text;
                String procedure = _procedureController.text;

                if (name.isNotEmpty &&
                    _selectedCategory.isNotEmpty &&
                    ingredients.isNotEmpty &&
                    procedure.isNotEmpty) {
                  Map<String, dynamic> ingredientsMap =
                      json.decode(ingredients);
                  Recipe newRecipe = Recipe(
                    id: 1, // ここでIDを適切に設定する必要があります
                    name: name,
                    category: _selectedCategory,
                    ingredients: ingredientsMap,
                    procedure: procedure,
                  );

                  _nameController.clear();
                  _selectedCategory = ingredientCategories[0];
                  _ingredientsController.clear();
                  _procedureController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name が $_selectedCategory に追加されました'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('すべての項目を入力してください'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
