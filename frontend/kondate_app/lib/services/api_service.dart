import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/ingredient.dart';

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

//ApiGatewayから材料を取得

Future<Map<int, Ingredient>> getIngredientFromApi() async {
  final response =
      await http.get(Uri.parse(apiRoute)); //ApiGateway $apiRoute/ingredients/
  Map<int, Ingredient> ingredientMap = {};

  if (response.statusCode == 200) {
    //jsonデータをパース
    List<Map<int, dynamic>> jsonData = json.decode(response.body);

    //idをキーにして材料を取得)
    for (int i = 0; i < jsonData.length; i++) {
      ingredientMap[jsonData[i]['id']] = Ingredient.fromJson(jsonData[i]);
    }
    return ingredientMap;
  } else {
    throw Exception('Failed to load ingredient');
  }
}