// ingredient_list_tile.dart
import 'package:flutter/material.dart';
import 'package:kondate_app/models/ingredient.dart';

class IngredientListTile extends StatelessWidget {
  final Ingredient ingredient;
  final bool isSelected;
  final Function(bool?) onCheckboxChanged;
  final Function() onEditPressed;
  final Function() onDeletePressed;

  const IngredientListTile({
    super.key,
    required this.ingredient,
    required this.isSelected,
    required this.onCheckboxChanged,
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
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: onCheckboxChanged,
              ),
              Text(ingredient.name),
            ],
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
