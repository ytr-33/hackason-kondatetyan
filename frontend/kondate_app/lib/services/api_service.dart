import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/models/recipe.dart';

// ApiGatewayから材料を取得
Future<Map<num, Ingredient>> getIngredientFromApi() async {
  final response = await http.get(Uri.parse('$apiRoute/ingredients'));
  Map<num, Ingredient> ingredientMap = {};

  if (response.statusCode == 200) {
    // jsonデータをパース
    final List jsonData =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;

    for (final item in jsonData) {
      ingredientMap[item['id']] = Ingredient.fromJson(item);
    }

    return ingredientMap;
  } else {
    throw Exception('Failed to load ingredient');
  }
}

Future<num> postIngredientToApi(IngredientExceptId ingredientExceptId) async {
  var request = json.encode(ingredientExceptId);
  final requestUtf = utf8.encode(request);

  final response =
      await http.post(Uri.parse('$apiRoute/ingredients'), body: requestUtf);
  final responseUtf = json.decode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return responseUtf as num;
  } else {
    throw Exception('Failed to post ingredient');
  }
}

Future<void> putIngredientToApi(Ingredient ingredient) async {
  IngredientExceptId ingredientExceptId = IngredientExceptId(
    name: ingredient.name,
    category: ingredient.category,
    unit: ingredient.unit,
  );

  final request = json.encode(ingredientExceptId);
  final requestUtf = utf8.encode(request);

  final response = await http.put(
      Uri.parse('$apiRoute/ingredients/${ingredient.id}'),
      body: requestUtf);
  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 204) {
    debugPrint('更新成功');
  } else {
    throw Exception('Failed to put ingredient');
  }
}

Future<void> deleteIngredientToApi(num id) async {
  final response = await http.delete(Uri.parse('$apiRoute/ingredients/$id'));
  if (response.statusCode == 204) {
    debugPrint(response.body);
  } else {
    throw Exception('Failed to delete ingredient');
  }
}

// ApiGatewayからレシピを取得
Future<Map<num, Recipe>> getRecipeFromApi() async {
  final response = await http.get(Uri.parse('$apiRoute/recipes'));
  Map<num, Recipe> recipeMap = {};

  if (response.statusCode == 200) {
    // jsonデータをパース
    final List jsonData = json.decode(utf8.decode(response.bodyBytes));

    for (final item in jsonData) {
      recipeMap[item['id']] = Recipe.fromJson(item);
    }

    return recipeMap;
  } else {
    throw Exception('Failed to load ingredient');
  }
}

Future<num> postRecipeToApi(RecipeExceptId recipeExceptId) async {
  print('ToApi1:${recipeExceptId.ingredients}}');
  var request = json.encode(recipeExceptId);
  final requestUtf = utf8.encode(request);

  final response =
      await http.post(Uri.parse('$apiRoute/recipes'), body: requestUtf);
  final responseUtf = json.decode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return responseUtf as num;
  } else {
    throw Exception('Failed to post recipe');
  }
}

Future<void> putRecipeToApi(Recipe recipe) async {
  RecipeExceptId recipeExceptId = RecipeExceptId(
    name: recipe.name,
    category: recipe.category,
    ingredients: json.encode(recipe.ingredients),
    procedure: recipe.procedure,
  );

  final request = json.encode(recipeExceptId);
  final requestUtf = utf8.encode(request);

  final response = await http.put(Uri.parse('$apiRoute/recipes/${recipe.id}'),
      body: requestUtf);
  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 504) {
    debugPrint('更新成功');
  } else {
    throw Exception('Failed to put ingredient');
  }
}

Future<void> deleteRecipeToApi(num id) async {
  final response = await http.delete(Uri.parse('$apiRoute/recipes/$id'));
  if (response.statusCode == 204) {
    debugPrint(response.body);
  } else {
    throw Exception('Failed to delete recipe');
  }
}

Future<List<Recipe>> postRecipeProposalFromApi(
    List<num> selectedIngredients) async {
  Recipe recipe;
  List<Recipe> recipeList;
  debugPrint('ここまできてるよ');
  final request = utf8.encode(json.encode(selectedIngredients));
  final response = await http.post(
      Uri.parse(
        '$apiRoute/recipes/proposal',
      ),
      body: request);

  if (response.statusCode == 200) {
    // jsonデータをパース
    final List jsonData = json.decode(utf8.decode(response.bodyBytes));

    if (jsonData.isEmpty) {
      return [];
    } else {
      recipeList = [];
      for (final item in jsonData) {
        recipe = Recipe.fromJson(item);
        recipeList.add(recipe);
      }
      return recipeList;
    }
  } else {
    throw Exception('Failed to find recipe');
  }
}

Future<String> postRecipeAiProposalFromApi(
    List<num> selectedIngredients) async {
  final request = utf8.encode(json.encode(selectedIngredients));
  final response = await http.post(
      Uri.parse(
        '$apiRoute/recipes/proposal/ai-proposal',
      ),
      body: request);

  if (response.statusCode == 200) {
    // jsonデータをパース
    final jsonData =
        response.bodyBytes; //json.decode(utf8.decode(response.bodyBytes));
    debugPrint('レスポンス：${jsonData.runtimeType.toString()}');
    debugPrint(
        'レスポンス：${utf8.decode(jsonData).replaceAll(r'\n', '\n').toString()}');
    final String answer =
        utf8.decode(jsonData).replaceAll(r'\n', '\n').toString();
    return answer;
  } else if (response.statusCode == 504) {
    return '時間内にレシピが見つかりませんでした。';
  } else {
    throw Exception('Failed to find recipe');
  }
}
