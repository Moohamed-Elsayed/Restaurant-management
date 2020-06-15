import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/Trending.dart';
import 'package:food/screens/table/details/form_view_food.dart';
import 'package:food/service/food_database.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTrending extends StatelessWidget {
  final Food food;

  CustomTrending({this.food});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    List<dynamic> tempList = [];
    return StreamBuilder<Trending>(
      stream: FoodDatabase().trendingList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Trending allTrending = snapshot.data;
          tempList = allTrending.idList;
          bool check = false;

          tempList.forEach((element) {
            if (element == food.id) {
              check = true;
              return;
            }
          });
          if (check) {
            return Container(
              width: screenWidth / 1,
              height: screenHeight / 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FormViewFood(idFood: food.id)));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
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
                          image: food.image,
                          fit: BoxFit.fitWidth,
                          height: screenHeight / 3,
                          width: screenWidth / 1,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
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
                                food.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.courgette(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20.0)),
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
          } else {
            return SizedBox(
              height: 0,
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
