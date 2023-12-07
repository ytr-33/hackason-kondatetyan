import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/services/api_service.dart';

class EditIngredientPage extends HookWidget {
  final Ingredient ingredient;

  const EditIngredientPage({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    final ingredientNameController =
        useTextEditingController(text: ingredient.name);
    String selectedCategory = ingredient.category;
    final unitController = useTextEditingController(text: ingredient.unit);

    return Scaffold(
      appBar: AppBar(
        title: const Text('材料の編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: ingredientNameController,
              decoration: const InputDecoration(labelText: '材料名'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {},
              items: ingredientCategories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 20),
            // 単位の入力フィールドを追加
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: '単位'),
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  onPressed: () async {
                    // 変更を保存
                    final updateIngredient = Ingredient(
                      id: ingredient.id,
                      name: ingredientNameController.text,
                      category: selectedCategory,
                      unit: unitController.text,
                    );

                    await putIngredientToApi(updateIngredient);

                    //状態管理を更新
                    final notifier =
                        ref.read(ingredientNotifierProvider.notifier);
                    notifier.updateIngredient(updateIngredient);
                  },
                  child: const Text('変更を保存'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
class EditIngredientPage extends StatefulWidget {
  final String ingredientName;
  final String ingredientCategory;
  final String ingredientUnit;

  const EditIngredientPage({
    Key? key,
    required this.ingredientName,
    required this.ingredientCategory,
    required this.ingredientUnit,
  }) : super(key: key);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  late TextEditingController _ingredientNameController;
  String _selectedCategory = '';
  late TextEditingController _unitController;

  @override
  void initState() {
    super.initState();
    _ingredientNameController =
        TextEditingController(text: widget.ingredientName);
    _selectedCategory = widget.ingredientCategory;
    _unitController = TextEditingController(text: widget.ingredientUnit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('材料の編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _ingredientNameController,
              decoration: const InputDecoration(labelText: '材料名'),
            ),
            const SizedBox(height: 20),
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
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 20),
            // 単位の入力フィールドを追加
            TextField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: '単位'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
              },
              child: const Text('変更を保存'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    print('新しい材料名: ${_ingredientNameController.text}');
    print('新しいカテゴリー: $_selectedCategory');
    print('新しい単位: ${_unitController.text}');
  }

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _unitController.dispose();
    super.dispose();
  }
}
*/