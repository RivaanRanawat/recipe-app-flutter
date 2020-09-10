import "package:flutter/material.dart";
import '../screens/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Map<String, bool> filters;
  final Function saveFilter;
  FiltersScreen(this.filters ,this.saveFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegatarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.filters["gluten"];
    _lactoseFree = widget.filters["lactose"];
    _vegan = widget.filters["vegan"];
    _vegatarian = widget.filters["vegatarian"];
    super.initState();
  }

  

  Widget buildSwitches(String title, bool val, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: val,
      subtitle: Text("Only include ${title} meals"),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "vegan": _vegan,
                "vegatarian" : _vegatarian,
                "lactose": _lactoseFree,
              };
            widget.saveFilter(selectedFilters);
          },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your Filters",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitches("Gluten-free", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitches("Vegatarian-free", _vegatarian, (newValue) {
                  setState(() {
                    _vegatarian = newValue;
                  });
                }),
                buildSwitches("Vegan-free", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildSwitches("Lactose-free", _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
