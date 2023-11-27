import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/models/ingredient.dart';
import 'package:kondate_app/pages/main_page.dart'; // 追加
import 'package:kondate_app/services/api_service.dart'; // 追加

final ingredientsProvider = FutureProvider<List<Ingredient>>((ref) async {
  // 1から20までのIDでAPIからデータをフェッチ
  List<Future<Ingredient>> fetchFutures = List.generate(
    20,
    (index) => fetchIngredient(index + 1),
  );

  // フェッチしたデータを一括で取得
  List<Ingredient> ingredients = await Future.wait(fetchFutures);

  return ingredients;
});

void main() async {
  // fetchIngredient 関数を呼び出して結果を取得
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final ingredients = await container.read(ingredientsProvider.future);

  // データをコンソールに表示
  print("APIから取得したデータ:");
  ingredients.forEach((ingredient) {
    print(ingredient.category);
  });

  runApp(
    const ProviderScope(
      child: KondateApp(),
    ),
  );
}

class KondateApp extends StatelessWidget {
  const KondateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
