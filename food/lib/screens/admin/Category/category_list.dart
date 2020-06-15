import 'package:flutter/material.dart';
import 'package:food/model/Category.dart';
import 'package:food/screens/admin/Category/category_list_Title.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<List<Category>>(context);
    return categoryList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return CategoryListTitle(category: categoryList[index]);
            });
  }
}
