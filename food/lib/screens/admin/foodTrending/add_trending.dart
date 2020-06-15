import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/foodTrending/add_list_trending.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class AddTrending extends StatefulWidget {
  static const id = 'AddTrending';
  @override
  _AddTrendingState createState() => _AddTrendingState();
}

class _AddTrendingState extends State<AddTrending> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(
      value: FoodDatabase().foods,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text('Add Food To Trending'),
          centerTitle: true,
        ),
        body: AddListTrending(),
      ),
    );
  }
}
