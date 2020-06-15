import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food/db/database_helper.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/User.dart';
import 'package:food/model/order_list_table.dart';
import 'package:food/service/food_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormViewFood extends StatefulWidget {
  final String idFood;
  FormViewFood({this.idFood});
  @override
  _FormViewFoodState createState() => _FormViewFoodState();
}

class _FormViewFoodState extends State<FormViewFood> {
  // for  component  price
  var count = 1;
  bool isClick = false;
  double totalPrice = 0.0;
  // for component  ingredients
  List<bool> inputCheck = List<bool>();
  List avoidingSubIngredients = List();
  //
  DataBaseHelper helper = DataBaseHelper();
  OrderTable orderTable;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final currentUser = Provider.of<User>(context);
    return StreamBuilder<Food>(
      stream: FoodDatabase(idFood: widget.idFood).currentFood,
      builder: (context, snapshot) {
        Food food = snapshot.data;

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: Text(
                food.name,
                style: GoogleFonts.chewy(
                    textStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    _showImage(food.image, screenWidth, screenHeight),
                    SizedBox(height: 20.0),
                    headerText('Ingredients'),
                    SizedBox(height: 5.0),
                    Text(
                      'You can choose the ingredients of the recipe you do not want',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: _showIngredients(food.subIngredients),
                    ),
                    SizedBox(height: 5.0),
                    _buildIncremantal(food.price)
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _addFoodToList(food.name, food.image),
              child: Icon(
                Icons.add,
                size: 35.0,
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.yellow,
              elevation: 5.0,
              child: Container(height: 50.0),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _showImage(String image, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        image,
        width: width,
        height: height / 3,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _showIngredients(List subIngredients) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildHorizontalList(
              parentIndex: index, subIngredients: subIngredients);
        });
  }

  Widget _buildHorizontalList({int parentIndex, List subIngredients}) {
    subIngredients.forEach((element) {
      inputCheck.add(false);
    });
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subIngredients.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10.0)),
                width: 100.0,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        subIngredients[index],
                        style: GoogleFonts.tradeWinds(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                      ),
                    ),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.amber),
                      child: Checkbox(
                        activeColor: Colors.amber,
                        checkColor: Colors.red,
                        value: inputCheck[index],
                        onChanged: (value) {
                          itemChange(value, index, subIngredients);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void itemChange(bool val, int index, List subIngredients) {
    setState(() {
      val
          ? avoidingSubIngredients.add(subIngredients[index])
          : avoidingSubIngredients.remove(subIngredients[index]);
      inputCheck[index] = val;
    });
  }

  Padding headerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      child: Text(
        text,
        style: GoogleFonts.candal(textStyle: TextStyle(fontSize: 18.0)),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildIncremantal(double price) {
    totalPrice = isClick ? totalPrice : price;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black54, width: 2)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
              color: Colors.black,
            ))),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                '$totalPrice JD',
                style: GoogleFonts.lacquer(
                    textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.green)),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: <Widget>[
                  Text(
                    '$count',
                    style: GoogleFonts.monda(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                      totalPrice = price * count;
                      isClick = true;
                    });
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 30.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (count != 1) {
                        count--;
                        totalPrice = totalPrice - price;
                        isClick = true;
                      }
                    });
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _addFoodToList(String nameFood, String image) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    String avoid = '';
    if (avoidingSubIngredients.length == 0) {
      avoid = 'no avoid';
    } else {
      avoidingSubIngredients.forEach((element) {
        avoid = element + ',' + avoid;
      });
    }
    orderTable = OrderTable(nameFood, image, count, totalPrice, date, avoid);
    int result;
    result = await helper.insertOrder(orderTable);
    if (result != 0) {
      Navigator.of(context).pop();
    } else {}
  }
}
