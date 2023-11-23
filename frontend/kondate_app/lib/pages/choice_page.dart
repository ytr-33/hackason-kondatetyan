import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/pages/add_ingredient_page.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  List<String> checkedValues = [];

  List<String> categories = ['肉類', '魚介類', '野菜類', 'その他'];

  List<Ingredient> ingredients = [
    Ingredient(1, 'ベーコン', '肉類'),
    Ingredient(2, '豚ひき肉', '肉類'),
    Ingredient(3, '牛豚ミンチ', '肉類'),
    Ingredient(4, '鳥もも肉', '肉類'),
    Ingredient(5, '鳥むね肉', '肉類'),
    Ingredient(6, 'えび', '魚介類'),
    Ingredient(7, 'ホタテ', '魚介類'),
    Ingredient(8, 'サーモン', '魚介類'),
    Ingredient(9, 'カツオ', '魚介類'),
    Ingredient(10, 'うなぎ', '魚介類'),
    Ingredient(11, 'キャベツ', '野菜類'),
    Ingredient(12, 'じゃがいも', '野菜類'),
    Ingredient(13, 'ほうれん草', '野菜類'),
    Ingredient(14, 'バジル', '野菜類'),
    Ingredient(15, '人参', '野菜類'),
    Ingredient(16, '玉ねぎ', '野菜類'),
    Ingredient(17, '米', 'その他'),
    Ingredient(18, 'パスタ', 'その他'),
  ];

  void clearSelection() {
    setState(() {
      checkedValues.clear();
    });
  }

  void showSelectedIngredients() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Ingredients'),
          content: Column(
            children: checkedValues.map((ingredient) => Text(ingredient)).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String category in categories)
                    ExpansionTile(
                      title: Text(category),
                      children: [
                        for (Ingredient ingredient in ingredients)
                          if (ingredient.category == category)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: checkedValues.contains(ingredient.name),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value != null && value) {
                                              checkedValues.add(ingredient.name);
                                            } else {
                                              checkedValues.remove(ingredient.name);
                                            }
                                          });
                                        },
                                      ),
                                      Text(ingredient.name),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // 削除ボタンが押されたときの処理
                                      setState(() {
                                        checkedValues.remove(ingredient.name);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.check),
            label: 'Get Menu',
            onTap: () {
              // Get Menu ボタンが押されたときの処理
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.list),
            label: 'Selected',
            onTap: () {
              showSelectedIngredients();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add Ingredient',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const AddIngredientPage();
              },));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.clear),
            label: 'Clear Check',
            onTap: () {
              clearSelection();
            },
          ),
        ],
      ),
    );
  }
}
