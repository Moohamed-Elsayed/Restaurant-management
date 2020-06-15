import 'package:flutter/material.dart';
import 'package:food/model/Category.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/screens/table/category/view_food_category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomCategory extends StatelessWidget {
  final Category category;
  CustomCategory({this.category});
  @override
  Widget build(BuildContext context) {
    final nameCategory = Provider.of<NameCategory>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth / 2,
      height: screenHeight / 4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            nameCategory.setNameCategory(category.nameCategory);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewFoodCategory()));
          },
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  image: category.image,
                  fit: BoxFit.cover,
                  height: screenHeight / 4,
                  width: screenWidth / 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54])),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Text(
                        category.nameCategory,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.courgette(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
