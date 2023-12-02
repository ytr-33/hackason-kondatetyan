import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kondate_app/configs/constants.dart';
import 'package:kondate_app/models/ingredient.dart';

Future<Ingredient> getIngredientFromApi(int id) async {
  final response = await http.get(Uri.parse('$apiRoute/pokemon/$id'));
  if (response.statusCode == 200) {
    return Ingredient.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load ingredient');
  }
}
