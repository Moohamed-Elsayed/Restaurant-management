import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/foodTrending/add_trending.dart';
import 'package:food/screens/admin/foodTrending/list_Trending.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class ViewTrending extends StatefulWidget {
  static const id = 'ViewTrending';

  @override
  _ViewTrendingState createState() => _ViewTrendingState();
}

class _ViewTrendingState extends State<ViewTrending> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(
      value: FoodDatabase().foods,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text('Food Trending'),
          centerTitle: true,
        ),
        body: ListTrending(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddTrending.id);
          },
          backgroundColor: kBackgroundAdminLight,
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
