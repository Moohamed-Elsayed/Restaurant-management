import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/admin/Food/details_food.dart';

class FoodListTitle extends StatelessWidget {
  final Food food;

  FoodListTitle({@required this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsFood(idFood: food.id)));
        },
        child: Card(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      food.image,
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
                          food.name,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: kBackgroundAdmin,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700),
                        ),
                        Text('${food.price} JD',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: kBackgroundAdmin,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
