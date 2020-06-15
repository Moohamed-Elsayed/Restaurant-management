import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:food/model/Category.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/User.dart';
import 'package:food/screens/table/Trending/listview_trending.dart';
import 'package:food/screens/table/category/listview_category.dart';
import 'package:food/screens/table/order/view_order.dart';
import 'package:food/service/auth.dart';
import 'package:food/service/food_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainTable extends StatefulWidget {
  @override
  _MainTableState createState() => _MainTableState();
}

class _MainTableState extends State<MainTable> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamProvider<List<Category>>.value(
      value: FoodDatabase().category,
      child: StreamProvider<List<Food>>.value(
        value: FoodDatabase().foods,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            leading: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreenAccent,
                  child: Text(
                    currentUser != null
                        ? ' T${currentUser.displayName}' ?? 'T'
                        : 'T',
                    style: GoogleFonts.lobster(
                        textStyle:
                            TextStyle(color: Colors.black, fontSize: 20.0)),
                  ),
                ),
              ),
            ),
            title: Text(
              'Foodies',
              style: GoogleFonts.chewy(
                  textStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
            ),
            centerTitle: true,
            actions: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  child: InkWell(
                    onTap: () => _auth.signOut(),
                    child: Image.asset(
                      'images/logout.png',
                      width: 30,
                      height: 30.0,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight / 30),
                headerText('Trending'),
                Container(
                  height: screenHeight / 3,
                  child: ListViewTrending(),
                ),
                SizedBox(height: screenHeight / 30),
                headerText('Category'),
                Container(
                  height: screenHeight / 4,
                  child: ListViewCategory(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ViewOrder()));
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.fastfood),
          ),
        ),
      ),
    );
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
}
