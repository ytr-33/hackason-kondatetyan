import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';

class ShowRecipePage extends ConsumerWidget {
  const ShowRecipePage({Key? key, required this.answer}) : super(key: key);

  final Recipe answer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(ingredientNotifierProvider);
    final ingredientList = answer.ingredients;

    final ingredientList2 = transformData(ingredientList, provider);

    debugPrint(ingredientList2.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Detail'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                const Text('レシピ名: '),
                Text(answer.name),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('カテゴリー: '),
                Text(answer.category),
              ],
            ),
          ),
          const ListTile(
            title:Text('材料'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredientList2.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Text(ingredientList2[index]["name"] as String),
                    Text(
                        '${ingredientList2[index]["amount"].toString()}${ingredientList2[index]["unit"].toString()}'),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('手順'),
            subtitle: Text(answer.procedure),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> transformData(
    List<Map<String, dynamic>> data, Map<num, Ingredient?> idNameData) {
  for (int i = 0; i < data.length; i++) {
    num id = data[i]["id"];

    if (idNameData.containsKey(id)) {
      data[i]["name"] = idNameData[id]!.name;
      data[i]["unit"] = idNameData[id]!.unit;
    }
  }

  return data;
}
