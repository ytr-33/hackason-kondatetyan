import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/pages/main_page.dart';
import 'package:kondate_app/providers/ingredient_provider.dart';
import 'package:kondate_app/providers/recipe_provider.dart';

/// スプラッシュ画面 (ConsumerWidget)
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 別の Widget へ渡すため、例外的にここで notifier を取得
    final ingredientNotifier = ref.watch(ingredientNotifierProvider.notifier);
    final recipeNotifier = ref.watch(recipeNotifierProvider.notifier);

    return Scaffold(
      // Stack で Widget を重ねて表示
      body: Stack(
        children: [
          // 背側
          _DataInitView(
              recipeNotifier: recipeNotifier,
              ingredientNotifier: ingredientNotifier),
          // 腹側
          Center(
            // 適当なロゴとか
            child: Image.asset('assets/images/logo.png',width: 200,height: 200,),
          ),
        ],
      ),
    );
  }
}

/// データを準備するWidget (HookWidget)
/// スプラッシュ画面と1つにまとめたいときは HookConsumerWidget を使う
class _DataInitView extends HookWidget {
  const _DataInitView(
      {required this.ingredientNotifier, required this.recipeNotifier});

  /// この Widget は riverpod ではないため、自分で Notifier を用意できない
  /// なので外から渡してもらう
  final IngredientNotifier ingredientNotifier;
  final RecipeNotifier recipeNotifier;

  void initData(BuildContext context) async {
    /* ここでいろんな準備処理をする */

    // 適当に 3秒まつ (スプラッシュ画面の確認ができたら消してもOK)
    //const sec3 = Duration(seconds: 3);
    //await Future.delayed(sec3);

    await ingredientNotifier.fetchInitIngredient().catchError((err) {
      debugPrint(err);
    });

    await recipeNotifier.fetchInitRecipe().catchError((err) {
      debugPrint(err);
    });

    // メイン画面を準備
    final route = MaterialPageRoute(builder: (context) {
      return const MainPage();
    });

    // メイン画面へ移動
    if (context.mounted) {
      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    // useEffect を使うと画面が表示されたときに処理を実行できる
    useEffect(() {
      initData(context);
      return null;
    }, const []);
    // 大きさ 0 の Widget
    return const SizedBox.shrink();
  }
}
