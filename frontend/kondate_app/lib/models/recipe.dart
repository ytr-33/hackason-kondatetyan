class Recipe {
  int id;
  String name;
  String category;
  Map ingredients;
  String procedure;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.ingredients,
    required this.procedure,
  });

  Recipe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        category = json['category'],
        ingredients = json['ingredients'],
        procedure = json['procedure'];
}
