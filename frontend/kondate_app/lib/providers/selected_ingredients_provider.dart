import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_ingredients_provider.g.dart';

@riverpod
class SelectedIngredientsNotifier extends _$SelectedIngredientsNotifier {
  @override
  List<int> build() {
    return [];
  }

  void addState(int id) {
    state = [...state, id];
  }

  void clearState() {
    state = [];
  }

  void removeState(int id) {
    state = [...state]..remove(id);
  }
}
