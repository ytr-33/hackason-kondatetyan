import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/pages/main_page.dart';

void main() {
  // アプリケーションを起動する
  // Riverpod の ProviderScope で囲む
  runApp(const ProviderScope(child: KondateApp()));
}

class KondateApp extends StatelessWidget {
  // コンストラクタ: インスタンスを作成するときに呼び出される
  const KondateApp({super.key});

  @override
  Widget build(BuildContext context) {
    // アプリケーションのエントリーポイントとなるウィジェット
    return MaterialApp(
      // ホーム画面は MainPage ウィジェット
      home: const MainPage(),
      // アプリケーションのテーマデータ
      theme: ThemeData(
        // プライマリーカラーを設定
        primarySwatch: Colors.green,
        // チェックボックスのテーマデータ
        checkboxTheme: CheckboxThemeData(
          // チェックボックスの形を円形に設定
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
