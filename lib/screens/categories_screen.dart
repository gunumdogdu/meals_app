import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Meal',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: DUMMY_CATEGORIES
              .map(
                (catData) =>
                    CategoryItem(catData.id, catData.title, catData.color),
              )
              .toList(),
        ));
  }
}
