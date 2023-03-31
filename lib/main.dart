import 'package:flutter/material.dart';
import 'dummy_data.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _avaliableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //REMOVED DEBUG BANNER FOR AEST. PURPOSES
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: Colors.red.shade50,
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ).copyWith(
          secondary: Colors.deepPurple,
          surface: Colors.grey,
          error: Colors.red,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
              bodySmall: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              bodyMedium: TextStyle(
                  color: Color.fromRGBO(250, 249, 246, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'RobotoCondensed'),
              titleLarge: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
              displayMedium: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
                fontSize: 16,
              ),
              displayLarge: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple),
            ),
        appBarTheme: AppBarTheme(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.amber,
          ),
          //DID NOT UNDERSTAND
          titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'Raleway',
              fontSize: 24,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
      ),

      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoritedMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_avaliableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
