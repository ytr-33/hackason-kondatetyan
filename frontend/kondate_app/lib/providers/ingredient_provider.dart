import 'package:kondate_app/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kondate_app/services/api_service.dart';
part 'ingredient_provider.g.dart';

// スプラッシュ画面で準備したデータを残しておくために keepAlive する
@Riverpod(keepAlive: true)
class IngredientNotifier extends _$IngredientNotifier {
  Map<int, Ingredient?> ingredientMap = {};

  @override
  Map<int, Ingredient?> build() {
    return ingredientMap;
  }

  // 材料をMapに追加
  void addIngredient(Ingredient ingredient) {
    ingredientMap[ingredient.id] = ingredient;
  }

  // 材料をAPIから取得
  Future<void> fetchIngredient(int id) async {
    ingredientMap[id] = null;
    addIngredient(await getIngredientFromApi(id));
  }
/*
  // 材料をIDで取得
  Future<Ingredient?> byID(int id) async {
    // 見つからないときは先に通信してデータを持ってくる
    if (ingredientMap.containsKey(id) == false) {
      await fetchIngredient(id); // ここで時間がかかっている
    }
    return ingredientMap[id]; // 上の関数に await をつけたので、ちゃんと通信が終わってからここにくる
  }*/
}
