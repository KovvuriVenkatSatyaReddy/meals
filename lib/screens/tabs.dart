import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controllers/favorite_meals_controller.dart';
import 'package:meals/controllers/filters_controller.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFliters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final filterController = Get.put(FilterController());
  final favController = Get.put(FavoriteMealsController());

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Get.to(() => const FilterScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = GetBuilder<FilterController>(
      builder: (controller) {
        return CategoriesScreen(
          availableMeals: controller.filteredMeals(),
        );
      },
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = GetBuilder<FavoriteMealsController>(
        builder: (controller) {
          return MealsScreen(
            meals: controller.favoriteMeals,
          );
        },
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectscreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
