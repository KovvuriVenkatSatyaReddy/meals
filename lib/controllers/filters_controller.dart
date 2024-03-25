import 'package:get/get.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterController extends GetxController {
  Map<Filter, bool> activeFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false
  };

  void setFilter(Filter filter, bool isSet) {
    activeFilters[filter] = isSet;
    update();
  }

  List<Meal> filteredMeals() {
    return dummyMeals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree)
        return false;
      if (activeFilters[Filter.vegan]! && !meal.isVegan) return false;
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      return true;
    }).toList();
  }
}
