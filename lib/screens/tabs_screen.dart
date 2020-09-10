import "package:flutter/material.dart";
import '../models/meal.dart';
import './main_drawer.dart';
import './categories_screen.dart';
import './favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoouritedMeal;

  TabsScreen(this.favoouritedMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        "screen": CategoriesScreen(),
        "title": "Categories",
      },
      {
        "screen": FavouritesScreen(widget.favoouritedMeal),
        "title": "Favourites",
      },
    ];
    super.initState();
  }

  void _selectPages(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPages,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            title: Text("Favourites"),
          ),
        ],
      ),
    );
  }
}
