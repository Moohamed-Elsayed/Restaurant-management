import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/admin/Category/CategoryFood/add_food_category.dart';
import 'file:///G:/Flutter/Flutter_leeson/Flutter_with_Firebase/foods/food/lib/screens/admin/Category/CategoryFood/list_category_food.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class ViewListFoodCategory extends StatefulWidget {
  @override
  _ViewListFoodCategoryState createState() => _ViewListFoodCategoryState();
}

class _ViewListFoodCategoryState extends State<ViewListFoodCategory> {
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context, listen: false);
    return StreamProvider<List<Food>>.value(
      value: FoodDatabase().foods,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text(nameCategory == null
              ? ''
              : ' Category ${nameCategory.currentNameCategory}'),
          centerTitle: true,
        ),
        body: ListCategoryFood(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddFoodCategory.id);
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
