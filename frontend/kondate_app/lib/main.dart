import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kondate_app/pages/splash.dart';

void main() async{

  await dotenv.load(fileName: '.env');

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
      home: const SplashPage(),
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
