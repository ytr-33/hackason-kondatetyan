import 'package:flutter/material.dart';
import 'package:kondate_app/pages/main_page.dart';

void main() {
  runApp(const KondateApp());
}

class KondateApp extends StatelessWidget {
  const KondateApp({super.key});

  @override
  Widget build(BuildContext context) {
//    ThemeMode mode = ThemeMode.system;

    return MaterialApp(
      home: const MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
