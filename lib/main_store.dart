import 'package:flutter/material.dart';

import 'home/models/recipe.dart';

class MainStore extends ChangeNotifier {
  List<Recipe> recipes;

  notify() {
    notifyListeners();
  }
}
