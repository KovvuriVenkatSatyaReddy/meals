import 'package:get/get.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsController extends GetxController {
  List<Meal> favoriteMeals = [];
  void addMeal(Meal meal) {
    favoriteMeals.add(meal);
    update();
  }

  void removeMeal(Meal meal) {
    favoriteMeals.remove(meal);
    update();
  }

  bool toggleFavoriteStatus(Meal meal) {
    if (favoriteMeals.contains(meal)) {
      removeMeal(meal);
      return false;
    }
    addMeal(meal);
    return true;
  }
}
