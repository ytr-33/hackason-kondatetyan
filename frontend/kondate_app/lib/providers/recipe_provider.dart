import 'package:kondate_app/models/recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kondate_app/services/api_service.dart';
part 'recipe_provider.g.dart';

// スプラッシュ画面で準備したデータを残しておくために keepAlive する
@Riverpod(keepAlive: true)
class RecipeNotifier extends _$RecipeNotifier {
  final Map<num, Recipe?> _recipeMap = {};

  @override
  Map<num, Recipe?> build() {
    return _recipeMap;
  }

  ////////// ApiGatewayの場合 //////////

  //最初のみ材料を取得しstateに格納
  Future<void> fetchInitRecipe() async {
    final newState = await getRecipeFromApi();
    state = newState; 
  }

  //材料を追加
  void addRecipe(Recipe recipe) {
    state[recipe.id] = recipe;
  }

  void updateRecipe(Recipe recipe) {
    state[recipe.id] = recipe;
  }

  void removeRecipe(num id) {
    state.remove(id);
  }
}