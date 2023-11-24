import 'package:flutter/material.dart';
import 'package:kondate_app/models/ingredient.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});
  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = '肉類'; // 新しく追加した行
  List<String> categories = ['肉類', '魚介類', '野菜類', 'その他'];
  List<Ingredient> ingredients = [
    Ingredient(1, 'テスト', '肉類'),
    Ingredient(2, 'テスト2', '魚介類'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('材料を追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '材料の名前'),
            ),
            const SizedBox(height: 16.0),
            // カテゴリーのドロップダウンメニュー
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: categories.map((String category) {
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
              decoration: InputDecoration(labelText: 'カテゴリ'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 入力された材料を追加
                String name = _nameController.text;

                if (name.isNotEmpty && _selectedCategory.isNotEmpty) {
                  // ユーザーが名前とカテゴリを入力した場合のみ追加
                  Ingredient newIngredient = Ingredient(
                    ingredients.length + 1,
                    name,
                    _selectedCategory,
                  );
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
