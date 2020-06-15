import 'package:flutter/material.dart';
import 'package:food/model/Category.dart';
import 'package:food/screens/admin/Category/category_list_Title.dart';
import 'package:food/screens/table/category/custom_category.dart';
import 'package:provider/provider.dart';

class ListViewCategory extends StatefulWidget {
  @override
  _ListViewCategoryState createState() => _ListViewCategoryState();
}

class _ListViewCategoryState extends State<ListViewCategory> {
  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<List<Category>>(context);
    return categoryList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return CustomCategory(category: categoryList[index]);
            });
  }
}
