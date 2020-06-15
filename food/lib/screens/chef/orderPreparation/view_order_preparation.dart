import 'package:flutter/material.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/chef/main-chef.dart';
import 'package:food/screens/chef/orderPreparation/list_view_order_chef.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPreparation extends StatefulWidget {
  @override
  _OrderPreparationState createState() => _OrderPreparationState();
}

class _OrderPreparationState extends State<OrderPreparation> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<OrderUpload>>.value(
      value: OrderDataBase().orderChefAllData,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          title: Text(
            'Order Preparation',
            style: GoogleFonts.chewy(
                textStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainChef()),
                  (route) => false);
            },
          ),
        ),
        body: ListViewChef(),
      ),
    );
  }
}
