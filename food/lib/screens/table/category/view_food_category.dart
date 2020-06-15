import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/table/category/list_food_category.dart';
import 'package:food/screens/table/order/view_order.dart';
import 'package:food/service/food_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewFoodCategory extends StatefulWidget {
  @override
  _ViewFoodCategoryState createState() => _ViewFoodCategoryState();
}

class _ViewFoodCategoryState extends State<ViewFoodCategory> {
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context, listen: false);
    return StreamProvider<List<Food>>.value(
      value: FoodDatabase().foods,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            nameCategory == null
                ? ''
                : ' Category ${nameCategory.currentNameCategory}',
            style: GoogleFonts.chewy(
                textStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
          ),
          centerTitle: true,
        ),
        body: ListFoodCategory(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ViewOrder()));
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.fastfood),
        ),
      ),
    );
  }
}
