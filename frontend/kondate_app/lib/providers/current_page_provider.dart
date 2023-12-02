import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_page_provider.g.dart';

@riverpod
class CurrentPageNotifier extends _$CurrentPageNotifier {
  @override
  int build() {
    return 0;
  }

  void updateState(int index) {
    state = index;
  }
}
