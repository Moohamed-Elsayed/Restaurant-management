import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/model/User.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/chef/order/order_list.dart';
import 'package:food/screens/chef/orderPreparation/view_order_preparation.dart';
import 'package:food/service/auth.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainChef extends StatefulWidget {
  static const id = 'Mainchef';
  @override
  _MainChefState createState() => _MainChefState();
}

class _MainChefState extends State<MainChef> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamProvider<List<OrderUpload>>.value(
      value: OrderDataBase().order,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            currentUser != null
                ? 'Chef : ${currentUser.displayName}' ?? 'not Found Name '
                : 'Admin',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          automaticallyImplyLeading: false,
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w700)),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: screenHeight,
                  child: OrderList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OrderPreparation()));
          },
          backgroundColor: Colors.blueAccent,
          child: Image.asset(
            'images/cooking.png',
            width: 40.0,
          ),
        ),
      ),
    );
  }
}
