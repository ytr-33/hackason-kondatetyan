import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_page_provider.g.dart';

// スプラッシュ画面で準備したデータを残しておくために keepAlive する
@Riverpod(keepAlive: true)
class CurrentPageNotifier extends _$CurrentPageNotifier {

  @override
  int build(){
  return 0;
  }

  void changePage(int index) {
    state = index;
  } 
}