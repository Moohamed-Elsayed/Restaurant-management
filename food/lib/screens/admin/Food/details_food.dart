import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/Food/create_food.dart';
import 'package:food/service/food_database.dart';
import 'package:food/shared/loading.dart';

class DetailsFood extends StatefulWidget {
  final idFood;
  DetailsFood({@required this.idFood});
  @override
  _DetailsFoodState createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<DetailsFood> {
  FoodDatabase _foodDatabase = FoodDatabase();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Food>(
        stream: FoodDatabase(idFood: widget.idFood).currentFood,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Food _currentFood = snapshot.data;
            return Scaffold(
              backgroundColor: kBackgroundAdmin,
              appBar: AppBar(
                backgroundColor: kBackgroundAdminLight,
                title: Text(''),
                actions: <Widget>[
                  RaisedButton.icon(
                    color: kBackgroundAdminMoreLight,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateFood(
                                currentFood: _currentFood,
                                isUpdating: true,
                              )));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    label: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton.icon(
                    color: kBackgroundAdminMoreLight,
                    onPressed: () {
                      _foodDatabase.deleteFood(_currentFood);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            _currentFood.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_currentFood.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              '${_currentFood.price} JD',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Ingredients',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, right: 20.0, left: 20.0),
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(8),
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: _currentFood.subIngredients
                              .map((e) => Card(
                                    color: kBackgroundAdminMoreLight,
                                    child: Center(
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
