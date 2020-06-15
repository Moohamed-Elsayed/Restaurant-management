import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/Food/create_food.dart';
import 'package:food/screens/admin/Food/food_List.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class ManageFood extends StatefulWidget {
  static const id = 'ManageFood';
  @override
  _ManageFoodState createState() => _ManageFoodState();
}

class _ManageFoodState extends State<ManageFood> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(
      value: FoodDatabase().foods,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text('Food'),
          centerTitle: true,
        ),
        body: FoodList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateFood(
                      isUpdating: false,
                      currentFood: Food(),
                    )));
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
