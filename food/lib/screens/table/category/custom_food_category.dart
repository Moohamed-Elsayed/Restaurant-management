import 'package:flutter/material.dart';
import 'package:food/model/Category.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/table/details/form_view_food.dart';
import 'package:food/service/food_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomFoodCategory extends StatefulWidget {
  final Food food;
  CustomFoodCategory({this.food});
  @override
  _CustomFoodCategoryState createState() => _CustomFoodCategoryState();
}

class _CustomFoodCategoryState extends State<CustomFoodCategory> {
  // create object from database
  FoodDatabase _foodDatabase = FoodDatabase();
  List tempList = [];
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context, listen: false);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<Category>(
      stream: FoodDatabase(nameCategory: nameCategory.currentNameCategory)
          .categoryData,
      builder: (context, snaphot) {
        if (snaphot.hasData) {
          Category specificCategory = snaphot.data;
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
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            FormViewFood(idFood: widget.food.id)));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: screenHeight / 3,
                        width: screenWidth / 1,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0)
                            ]),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loading.gif',
                          placeholderScale: 10,
                          image: widget.food.image,
                          fit: BoxFit.fitWidth,
                          height: screenHeight / 3,
                          width: screenWidth / 1,
                        ),
                      ),
                      Container(
                        height: screenHeight / 4,
                        child: Center(
                          child: Text(
                            widget.food.name,
                            style: GoogleFonts.courgette(
                                textStyle: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.black12,
                              fontSize: 44.0,
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
