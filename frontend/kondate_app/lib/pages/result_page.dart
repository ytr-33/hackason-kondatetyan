import 'package:flutter/material.dart';
import 'package:kondate_app/models/recipe.dart';
import 'package:kondate_app/pages/show_recipe_page.dart';

class ResultPage extends StatelessWidget {
  final List<Recipe> answer;

  const ResultPage({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    debugPrint(answer.toString());
    debugPrint(answer.runtimeType.toString());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Recipes on My recipes'),
        ),
        body: ListView.builder(
          itemCount: answer.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(answer[index].name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowRecipePage(
                        answer: answer[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
