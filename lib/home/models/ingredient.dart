class Ingredient {
  int id;
  String name;
  double amount;

  String image;
  String unit;
  bool saved;

  Ingredient({
    this.id,
    this.name,
    this.amount,
    this.image,
    this.unit,
    bool saved,
  });

  factory Ingredient.fromJson(Map json) => Ingredient(
        id: json['id'],
        name: json['name'],
        amount: json['amount'] * 1.0,
        image: json['image'],
        unit: json['unit'],
        saved: false,
      );

  static List<Ingredient> listFromMap(Map json,
          {String key = "extendedIngredients"}) =>
      List<Ingredient>.from(json[key].map((x) => Ingredient.fromJson(x)));
}
