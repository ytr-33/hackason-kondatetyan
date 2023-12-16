import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'is_loading_provider.g.dart';

// スプラッシュ画面で準備したデータを残しておくために keepAlive する
@Riverpod(keepAlive: true)
class IsLoadingNotifier extends _$IsLoadingNotifier {

  @override
  bool build(){
  return false;
  }

  void isLoading() {
    state = true;
  }

  void isLoaded() {
    state = false;
  } 
}