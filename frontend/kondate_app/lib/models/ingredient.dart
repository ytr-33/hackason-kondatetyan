class Ingredient {
  int id;
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
      category: json['types'][0]['type']['name'],
      unit: json['name'],
    );
  }
}
