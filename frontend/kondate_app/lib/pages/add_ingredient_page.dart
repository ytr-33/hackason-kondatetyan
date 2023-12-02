import 'package:flutter/material.dart';
import 'package:kondate_app/data/ingredient.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/configs/constants.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});
  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = ingredientCategories.first; // 新しく追加した行
  final TextEditingController _unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ingredient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '材料名'),
            ),
            const SizedBox(height: 16.0),
            // カテゴリーのドロップダウンメニュー
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ingredientCategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: '単位'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 入力された材料を追加
                String name = _nameController.text;

                if (name.isNotEmpty && _selectedCategory.isNotEmpty) {
                  // ユーザーが名前とカテゴリを入力した場合のみ追加
                  Ingredient newIngredient = Ingredient(
                      id: ingredients.length + 1,
                      name: name,
                      category: _selectedCategory,
                      unit: 'g');
                  ingredients.add(newIngredient);

                  // 追加後に入力欄をクリア
                  _nameController.clear();

                  // ユーザーに成功メッセージを表示
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name が $_selectedCategory に追加されました'),
                    ),
                  );
                } else {
                  // エラーメッセージを表示
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('名前とカテゴリを入力してください'),
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
