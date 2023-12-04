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

  ////////// ApiGatewayの場合 //////////

  //最初のみ材料を取得
  Future<void> fetchInitIngredient() async {
    ingredientMap = await getIngredientFromApi();
  }

  ////////////////// PokeAPIの場合 //////////////////
  /*

  void addIngredient(Ingredient ingredient) {
    ingredientMap[ingredient.id] = ingredient;
  }


  Future<void> fetchIngredient(int id) async {
    ingredientMap[id] = null;
    addIngredient(await getIngredientFromApi(id));
  }

  // 材料をIDで取得（今回使用せず）
  Future<Ingredient?> byID(int id) async {
    // 見つからないときは先に通信してデータを持ってくる
    if (ingredientMap.containsKey(id) == false) {
      await fetchIngredient(id); // ここで時間がかかっている
    }
    return ingredientMap[id]; // 上の関数に await をつけたので、ちゃんと通信が終わってからここにくる
  }
  */
}
