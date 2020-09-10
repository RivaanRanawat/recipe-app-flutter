import "package:flutter/material.dart";
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favoritedMeal;
  FavouritesScreen(this.favoritedMeal);
  @override
  Widget build(BuildContext context) {
    return favoritedMeal.isEmpty ? 
    Center(child: Text("NO Favourited Meals Yet!"),)
    : 
    ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoritedMeal[index].id,
            title: favoritedMeal[index].title,
            affordability: favoritedMeal[index].affordability,
            complexity: favoritedMeal[index].complexity,
            duration: favoritedMeal[index].duration,
            imageUrl: favoritedMeal[index].imageUrl
          );
        },
        itemCount: favoritedMeal.length,
      );
  }
} 