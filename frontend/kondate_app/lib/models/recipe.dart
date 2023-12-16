import 'dart:convert';

class Recipe {
  num id;
  String name;
  String category;
  List<Map<String, dynamic>> ingredients;
  String procedure;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.ingredients,
    required this.procedure,
  });

  Recipe.fromJson(Map<String, dynamic> decodedJson)
      : id = decodedJson['id'] as num,
        name = decodedJson['name'] as String,
        category = decodedJson['category'] as String,
        ingredients = _parseIngredients(decodedJson['ingredients']),
        procedure = decodedJson['procedure'] as String;

  static List<Map<String, dynamic>> _parseIngredients(String ingredients) {
    final decodedList = json.decode(ingredients) as List<dynamic>;
    List<Map<String, dynamic>> ingredientsList = [];
    for (final item in decodedList) {
      ingredientsList.add(item as Map<String, dynamic>);
    } 
    return ingredientsList;
  }
}

class RecipeExceptId {
  String name;
  String category;
  String ingredients;
  String procedure;

  RecipeExceptId({
    required this.name,
    required this.category,
    required this.ingredients,
    required this.procedure,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'ingredients': ingredients,
      'procedure': procedure,
    };
  }
}
