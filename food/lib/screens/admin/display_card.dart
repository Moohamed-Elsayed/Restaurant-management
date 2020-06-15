import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/screens/admin/Category/view_category.dart';
import 'package:food/screens/admin/Food/view_food.dart';
import 'package:food/screens/admin/foodTrending/view_trending.dart';
import 'package:food/screens/admin/order/view_order.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GridDashboard extends StatelessWidget {
  // card data
  Items item1 =
      new Items(title: "Food", img: "images/food.png", goToPage: ManageFood.id);
  Items item2 = new Items(
      title: "Trending", img: "images/trending.png", goToPage: ViewTrending.id);
  Items item3 = new Items(
      title: "Category", img: "images/category.png", goToPage: ViewCategory.id);
  Items item4 = new Items(
      title: "Order", img: "images/order.png", goToPage: ViewOrder.id);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, data.goToPage),
              child: Container(
                decoration: BoxDecoration(
                    color: kBackgroundAdminLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 70,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  String goToPage;
  Items({this.title, this.img, this.goToPage});
}
