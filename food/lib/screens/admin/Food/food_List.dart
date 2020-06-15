import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'file:///G:/Flutter/Flutter_leeson/Flutter_with_Firebase/foods/food/lib/screens/admin/Food/food_list_Title.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return FoodListTitle(food: foodList[index]);
            });
  }
}
