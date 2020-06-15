import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:provider/provider.dart';

import 'food_title_category.dart';

class ListCategoryFood extends StatefulWidget {
  @override
  _ListCategoryFoodState createState() => _ListCategoryFoodState();
}

class _ListCategoryFoodState extends State<ListCategoryFood> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return FoodTitleCategory(
                food: foodList[index],
              );
            });
  }
}
