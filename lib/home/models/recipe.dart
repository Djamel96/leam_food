import 'ingredient.dart';

class Recipe {
  int id;
  String title;
  String readyInMinutes;
  int servings;
  String image;
  double spoonacularScore;
  bool saved;
  List<Ingredient> ingredients;

  Recipe({
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.image,
    this.spoonacularScore,
    this.saved,
    this.ingredients,
  });

  factory Recipe.fromJson(Map json) => Recipe(
        id: json['id'],
        title: json['title'],
        readyInMinutes: json['readyInMinutes'].toString(),
        image: json['image'],
        spoonacularScore: json['spoonacularScore'],
        saved: false,
        ingredients: Ingredient.listFromMap(json),
      );

  static List<Recipe> listFromMap(Map json, {String key = "recipes"}) =>
      List<Recipe>.from(json[key].map((x) => Recipe.fromJson(x)));
}
