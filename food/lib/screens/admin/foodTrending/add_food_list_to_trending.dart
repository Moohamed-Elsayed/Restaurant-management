import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/Trending.dart';
import 'package:food/service/food_database.dart';

class AddFoodListTrending extends StatefulWidget {
  final Food food;

  AddFoodListTrending({this.food});

  @override
  _AddFoodListTrendingState createState() => _AddFoodListTrendingState();
}

class _AddFoodListTrendingState extends State<AddFoodListTrending> {
  // create object from database
  FoodDatabase _foodDatabase = FoodDatabase();
  List<dynamic> tempList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: StreamBuilder<Trending>(
        stream: FoodDatabase().trendingList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Trending allTrending = snapshot.data;
            bool check = false;
            tempList = allTrending.idList;
            tempList.forEach((element) {
              if (element == widget.food.id) {
                check = true;
                return;
              }
            });

            if (!check) {
              return Card(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, right: 16.0, left: 16.0),
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
                                color: Colors.blue,
                                onPressed: () {
                                  tempList.add(widget.food.id);
                                  allTrending.idList = tempList;
                                  _foodDatabase.addFoodToTrending(allTrending);
                                },
                                icon: Icon(
                                  Icons.playlist_add,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Add Trending',
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
            Trending allTrending = Trending();
            return Card(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
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
                              color: Colors.blue,
                              onPressed: () {
                                tempList.add(widget.food.id);
                                allTrending.idList = tempList;
                                _foodDatabase.addFoodToTrending(allTrending);
                              },
                              icon: Icon(
                                Icons.playlist_add,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Add Trending',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
