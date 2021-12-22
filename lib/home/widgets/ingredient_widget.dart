import 'package:flutter/material.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/home/models/ingredient.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final int servings;

  const IngredientWidget({Key key, this.ingredient, this.servings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xfff8f7f7),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Text(ingredient.name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColors.grey106)),
        trailing: Text(
            (ingredient.amount * servings).toString() + " " + ingredient.unit,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColors.grey106)),
      ),
    );
  }
}
