import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/foodTrending/add_food_list_to_trending.dart';
import 'package:provider/provider.dart';

class AddListTrending extends StatefulWidget {
  @override
  _AddListTrendingState createState() => _AddListTrendingState();
}

class _AddListTrendingState extends State<AddListTrending> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return AddFoodListTrending(food: foodList[index]);
            });
  }
}
