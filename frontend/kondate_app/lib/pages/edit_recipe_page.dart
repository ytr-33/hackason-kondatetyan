import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/main_page.dart';
import 'package:kondate_app/providers/current_page_provider.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/providers/recipe_provider.dart';
import 'package:kondate_app/services/api_service.dart';

class EditRecipePage extends HookWidget {
  const EditRecipePage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final recipeNameController = useTextEditingController(text: recipe.name);
    final selectedCategory = useState(recipe.category);
    final selectedIngredient1Id =
        useState(recipe.ingredients[0]["id"].toString());
    final selectedIngredient1AmountController = useTextEditingController(
        text: recipe.ingredients[0]["amount"].toString());
    final selectedIngredient2Id =
        useState(recipe.ingredients[1]["id"].toString());
    final selectedIngredient2AmountController = useTextEditingController(
        text: recipe.ingredients[1]["amount"].toString());
    final procedureController =
        useTextEditingController(text: recipe.procedure);

    Row inputIngredientRow({
      required Map<num, Ingredient?> ingredientMap,
      required ValueNotifier selectedIngredientId,
      required TextEditingController selectedIngredientAmountController,
      required String labelText,
    }) {
      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedIngredient1Id.value,
              items: ingredientMap.values.map((Ingredient? ingredient) {
                return DropdownMenuItem<String>(
                  value: ingredient!.id.toString(),
                  child: Text(ingredient.name),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  selectedIngredientId.value = value;
                }
              },
              decoration: InputDecoration(labelText: labelText),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: selectedIngredientAmountController,
              decoration: InputDecoration(
                labelText: '$labelTextの量',
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピの編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: recipeNameController,
              decoration: const InputDecoration(labelText: 'レシピ名'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedCategory.value,
              items: menuCategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  selectedCategory.value = value;
                }
              },
              decoration: const InputDecoration(labelText: 'カテゴリー'),
            ),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, _) {
                Map<num, Ingredient?> ingredientMap =
                    ref.watch(ingredientNotifierProvider);
                return Column(
                  children: [
                    inputIngredientRow(
                      ingredientMap: ingredientMap,
                      selectedIngredientId: selectedIngredient1Id,
                      selectedIngredientAmountController:
                          selectedIngredient1AmountController,
                      labelText: '材料1',
                    ),
                    const SizedBox(height: 16.0),
                    inputIngredientRow(
                      ingredientMap: ingredientMap,
                      selectedIngredientId: selectedIngredient2Id,
                      selectedIngredientAmountController:
                          selectedIngredient2AmountController,
                      labelText: '材料2',
                    ),
                    const SizedBox(height: 16.0),
                    // Add similar layout for ingredient 2 if needed
                  ],
                );
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: procedureController,
              decoration: const InputDecoration(labelText: '手順'),
            ),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  child: const Text('変更を保存'),
                  onPressed: () async {
                    final currentContext = context;
                    // 変更を保存
                    final updateRecipe = Recipe(
                      id: recipe.id,
                      name: recipeNameController.text,
                      category: selectedCategory.value,
                      ingredients: [
                        {
                          "id": num.parse(selectedIngredient1Id.value),
                          "amount": num.parse(
                              selectedIngredient1AmountController.value.text),
                        },
                        {
                          "id": num.parse(selectedIngredient2Id.value),
                          "amount": num.parse(
                              selectedIngredient2AmountController.value.text),
                        },
                      ],
                      procedure: procedureController.text,
                    );

                    await putRecipeToApi(updateRecipe);

                    //状態管理を更新
                    final notifier = ref.read(recipeNotifierProvider.notifier);
                    notifier.updateRecipe(updateRecipe);

                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        content: Text('id:${recipe.id} を更新しました'),
                      ),
                    );

                    Navigator.of(currentContext).push(
                      MaterialPageRoute(
                        builder: (currentContext) => MainPage(),
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
