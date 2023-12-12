

import 'package:flutter/material.dart';

class ShowRecipePage extends StatelessWidget {
  const ShowRecipePage({super.key,required this.answer});

  final List<dynamic> answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(answer[0]['name']),
          Text(answer[0]['procedure']),
          Text(answer[0]['category']),
          Text(answer[0]['ingredients'][0]['name']),
          Text(answer[0]['ingredients'][0]['amount'].toString()),
          Text(answer[0]['ingredients'][1]['name']),
          Text(answer[0]['ingredients'][1]['amount'].toString()),
        ],
      )
    );
  }
}