import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_mode_provider.g.dart';

@riverpod
class EditModeNotifier extends _$EditModeNotifier {
  @override
  bool build() {
    return false;
  }

  void updateState(bool value) {
    state = value;
  }
}
