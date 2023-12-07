import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_ingredients_provider.g.dart';

@riverpod
class SelectedIngredientsNotifier extends _$SelectedIngredientsNotifier {
  @override
  List<num> build() {
    return [];
  }

  void addState(num id) {
    state = [...state, id];
  }

  void clearState() {
    state = [];
  }

  void removeState(num id) {
    state = [...state]..remove(id);
  }
}
