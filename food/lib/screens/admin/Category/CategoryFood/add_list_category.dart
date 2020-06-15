import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/Category/CategoryFood/add_food_list_category.dart';
import 'package:provider/provider.dart';

class AddListCategory extends StatefulWidget {
  @override
  _AddListCategoryState createState() => _AddListCategoryState();
}

class _AddListCategoryState extends State<AddListCategory> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return AddFoodListCategory(food: foodList[index]);
            });
  }
}
