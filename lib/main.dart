import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
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
