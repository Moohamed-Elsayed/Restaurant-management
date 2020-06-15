import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:provider/provider.dart';

import 'ordre_list_view.dart';

class ViewOrder extends StatefulWidget {
  static final id = 'ViewOrder';
  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<OrderAdmin>>.value(
      value: OrderDataBase().orderAdmin,
      child: Scaffold(
        backgroundColor: kBackgroundAdmin,
        appBar: AppBar(
          backgroundColor: kBackgroundAdminLight,
          title: Text('Order'),
          centerTitle: true,
        ),
        body: OrderListView(),
      ),
    );
  }
}
