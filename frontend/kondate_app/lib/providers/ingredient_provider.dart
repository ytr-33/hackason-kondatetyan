import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ingredient_provider.g.dart';

@riverpod
class IngredientNotifier extends _$IngredientNotifier {
  @override
  List<Future<Ingredient>> build() {
    return List.generate(
      20,
      (index) => fetchIngredient(index + 1),
    );
  }
}
