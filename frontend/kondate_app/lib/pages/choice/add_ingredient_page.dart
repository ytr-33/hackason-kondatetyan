import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/main_page.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/services/api_service.dart';

class AddIngredientPage extends HookWidget {
  const AddIngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final selectedCategory = useState(ingredientCategories[0]);
    final unitController = useTextEditingController();

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
              controller: nameController,
              decoration: const InputDecoration(labelText: '材料名'),
            ),
            const SizedBox(height: 16.0),
            // カテゴリーのドロップダウンメニュー
            DropdownButtonFormField<String>(
              value: selectedCategory.value,
              items: ingredientCategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                // ドロップダウンメニューで選択されたカテゴリーを更新
                if (value != null) {
                  selectedCategory.value = value;
                }
              },
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: '単位'),
            ),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  child: const Text('追加'),
                  onPressed: () async {
                    // ユーザーが名前とカテゴリを入力した場合のみ追加
                    final currentContext = context;

                    IngredientExceptId newIngredient = IngredientExceptId(
                      name: nameController.value.text,
                      category: selectedCategory.value,
                      unit: unitController.value.text,
                    );

                    final response = await postIngredientToApi(newIngredient);

                    Ingredient ingredient = Ingredient(
                      id: response,
                      name: newIngredient.name,
                      category: newIngredient.category,
                      unit: newIngredient.unit,
                    );

                    // 材料を追加
                    final notifier =
                        ref.read(ingredientNotifierProvider.notifier);
                    notifier.addIngredient(ingredient);

                    // 追加後に入力欄をクリア
                    nameController.clear();
                    unitController.clear();

                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      const SnackBar(
                        content: Text('材料が追加されました'),
                      ),
                    );

                    Navigator.of(currentContext).push(
                      MaterialPageRoute(
                        builder: (currentContext) => const MainPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
