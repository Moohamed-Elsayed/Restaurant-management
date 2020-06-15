import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Category.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/admin/Category/CategoryFood/view_list_food_category.dart';
import 'package:provider/provider.dart';

class CategoryListTitle extends StatefulWidget {
  final Category category;

  CategoryListTitle({this.category});

  @override
  _CategoryListTitleState createState() => _CategoryListTitleState();
}

class _CategoryListTitleState extends State<CategoryListTitle> {
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: Card(
          color: kBackgroundAdminMoreLight,
          child: ListTile(
            onTap: () {
              nameCategory.setNameCategory(widget.category.nameCategory);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewListFoodCategory()));
            },
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  widget.category.image,
                ),
              ),
            ),
            title: Text(
              widget.category.nameCategory,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
