import 'package:flutter/material.dart';

class ResultAiPage extends StatelessWidget {
  final String answer;

  const ResultAiPage({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    debugPrint(answer.toString());
    debugPrint(answer.runtimeType.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Recipes from AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(answer),
      ),
    );
  }
}
