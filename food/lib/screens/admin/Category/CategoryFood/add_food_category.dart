import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/admin/Category/CategoryFood/add_list_category.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class AddFoodCategory extends StatefulWidget {
  static const id = 'AddFoodCategory';
  @override
  _AddFoodCategoryState createState() => _AddFoodCategoryState();
}

class _AddFoodCategoryState extends State<AddFoodCategory> {
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
              : 'Add Food To ${nameCategory.currentNameCategory}'),
          centerTitle: true,
        ),
        body: AddListCategory(),
      ),
    );
  }
}
