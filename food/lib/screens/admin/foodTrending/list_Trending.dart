import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:provider/provider.dart';

import 'food_list_trending.dart';

class ListTrending extends StatefulWidget {
  @override
  _ListTrendingState createState() => _ListTrendingState();
}

class _ListTrendingState extends State<ListTrending> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return FoodListTrending(food: foodList[index]);
            });
  }
}
