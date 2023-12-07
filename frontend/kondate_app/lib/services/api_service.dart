import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/ingredient.dart';

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

  debugPrint(ingredientExceptId.name);
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

// PokeAPIから材料を取得
/*
Future<Ingredient> getIngredientFromApi(int id) async {
  final response = await http.get(Uri.parse('$apiRoute/pokemon/$id')); // PokeAPI
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load ingredient');
  }
}
*/
