// ingredient_list_tile.dart
import 'package:flutter/material.dart';
import 'package:kondate_app/models/recipe.dart';

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;
  final Function() onEditPressed;
  final Function() onDeletePressed;

  const RecipeListTile({
    super.key,
    required this.recipe,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  color: Colors.grey,
                ),
                Text(
                  recipe.name,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEditPressed,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDeletePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
