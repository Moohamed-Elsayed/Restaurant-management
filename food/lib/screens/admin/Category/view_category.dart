import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Category.dart';
import 'package:food/screens/admin/Category/add_category.dart';
import 'package:food/screens/admin/Category/category_list.dart';
import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class ViewCategory extends StatefulWidget {
  static const id = 'ViewCategory';
  @override
  _ViewCategoryState createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Category>>.value(
      value: FoodDatabase().category,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text('Category Food '),
          centerTitle: true,
        ),
        body: CategoryList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddCategory.id);
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
