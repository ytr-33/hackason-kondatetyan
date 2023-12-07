import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<num> selectedIngredients;

  const ResultPage({Key? key, required this.selectedIngredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement logic to filter recipes based on selected ingredients
    // You can fetch the recipes from a data source and filter them here

    List<String> recipes = [
      'Recipe 1',
      'Recipe 2',
      // Add more recipes
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]),
          );
        },
      ),
    );
  }
}
