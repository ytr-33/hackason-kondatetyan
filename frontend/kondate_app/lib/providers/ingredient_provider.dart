import 'package:kondate_app/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kondate_app/services/api_service.dart';
part 'ingredient_provider.g.dart';

@riverpod
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
  void fetchIngredient(int id) async {
    ingredientMap[id] = null;
    addIngredient(await getIngredientFromApi(id));
  }

  // 材料をIDで取得
  Ingredient? byID(int id){
    if (ingredientMap.containsKey(id) == false) {
      fetchIngredient(id);
    }
    return ingredientMap[id];
  }
}
