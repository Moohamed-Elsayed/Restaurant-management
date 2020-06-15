import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/table/category/custom_food_category.dart';
import 'package:provider/provider.dart';

class ListFoodCategory extends StatefulWidget {
  @override
  _ListFoodCategoryState createState() => _ListFoodCategoryState();
}

class _ListFoodCategoryState extends State<ListFoodCategory> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return CustomFoodCategory(
                food: foodList[index],
              );
            });
  }
}
