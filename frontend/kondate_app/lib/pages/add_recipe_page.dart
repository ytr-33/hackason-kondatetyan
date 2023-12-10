import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/pages/menu_page.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/providers/recipe_provider.dart';
import 'package:kondate_app/services/api_service.dart';

class AddRecipePage extends HookWidget {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final selectedCategory = useState(menuCategories[0]);
    final selectedIngredient1Id = useState("1701955705.206");
    final selectedIngredient1AmountController =
        useTextEditingController(text: "0");
    final selectedIngredient2Id = useState("");
    final selectedIngredient2AmountController =
        useTextEditingController(text: "0");
    final procedureController = useTextEditingController();

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
        title: const Text('レシピの追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
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
            const SizedBox(height: 16.0),
            TextField(
              controller: procedureController,
              decoration: const InputDecoration(labelText: '手順'),
            ),
            const SizedBox(height: 16.0),

            Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  child: const Text('追加'),
                  onPressed: () async {
                    final currentContext = context;

                    RecipeExceptId newRecipe = RecipeExceptId(
                      name: nameController.value.text,
                      category: selectedCategory.value,
                      ingredients: [
                        {
                          "id": selectedIngredient1Id.value,
                          "amount": num.parse(
                              selectedIngredient1AmountController.value.text),
                        },
                        {
                          "id": selectedIngredient2Id.value,
                          "amount": num.parse(
                              selectedIngredient2AmountController.value.text),
                        },
                      ],
                      procedure: procedureController.value.text,
                    );

                    final response = await postRecipeToApi(newRecipe);

                    Recipe recipe = Recipe(
                      id: response,
                      name: newRecipe.name,
                      category: newRecipe.category,
                      ingredients: newRecipe.ingredients,
                      procedure: newRecipe.procedure,
                    );

                    final notifier = ref.read(recipeNotifierProvider.notifier);
                    notifier.addRecipe(recipe);

                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${newRecipe.name} が ${newRecipe.category} に追加されました'),
                      ),
                    );
                    Navigator.of(currentContext).push(
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(),
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
