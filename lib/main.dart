import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegatarian": false
  };

  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favouritedMeal = [];

  void setFilters(Map<String, bool> filterData) {
    filters = filterData;
    availableMeal = DUMMY_MEALS.where((element) {
      if(filters["gluten"] && !element.isGlutenFree) {
        return false;
      }
      if(filters["lactose"] && !element.isLactoseFree) {
        return false;
      }
      if(filters["vegan"] && !element.isVegan) {
        return false;
      }
      if(filters["vegatarian"] && !element.isVegetarian) {
        return false;
      }

      return true;
    }).toList();
  }

  void toggleFavourite(String mealId) {
    final existingIndex = favouritedMeal.indexWhere((element) => element.id == mealId);
    if(existingIndex>=0) {
      setState(() {
        favouritedMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouritedMeal.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool isMealFavourite(String id) {
    return favouritedMeal.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurple,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 24,
                fontFamily: "RobotoCondensed",
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: "/",
      routes: {
        "/": (ctx) => TabsScreen(favouritedMeal),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeal),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFavourite, isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(filters, setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
