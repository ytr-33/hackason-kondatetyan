class Ingredient {
  num id;
  String name;
  String category;
  String unit;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      unit: json['unit'],
    );
  }
}

class IngredientExceptId{
  String name;
  String category;
  String unit;

  IngredientExceptId({
    required this.name,
    required this.category,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'unit': unit,
    };
  }
}
