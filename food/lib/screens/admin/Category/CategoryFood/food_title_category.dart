import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Category.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/NameCategory.dart';

import 'package:food/service/food_database.dart';
import 'package:provider/provider.dart';

class FoodTitleCategory extends StatefulWidget {
  final Food food;

  FoodTitleCategory({this.food});

  @override
  _FoodTitleCategoryState createState() => _FoodTitleCategoryState();
}

class _FoodTitleCategoryState extends State<FoodTitleCategory> {
  // create object from database
  FoodDatabase _foodDatabase = FoodDatabase();
  List tempList = [];
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: StreamBuilder<Category>(
        stream: FoodDatabase(nameCategory: nameCategory.currentNameCategory)
            .categoryData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Category specificCategory = snapshot.data;
            try {
              tempList = specificCategory.idList;
            } catch (e) {}

            bool check = false;

            tempList.forEach((element) {
              if (element == widget.food.id) {
                check = true;
                return;
              }
            });

            if (check) {
              return Card(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.food.image,
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.food.name,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: kBackgroundAdmin,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text('${widget.food.price} JD',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: kBackgroundAdmin,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RaisedButton.icon(
                                color: Colors.red,
                                onPressed: () {
                                  tempList.removeWhere(
                                      (element) => element == widget.food.id);
                                  specificCategory.idList = tempList;
                                  _foodDatabase.deleteFoodFromCategory(
                                      widget.food.id,
                                      nameCategory.currentNameCategory);
                                },
                                icon: Icon(
                                  Icons.delete_forever,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Delete Trending',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                )),
                          ),
                        )
                      ],
                    ),
                  ));
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
