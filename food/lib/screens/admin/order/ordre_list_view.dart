import 'package:flutter/material.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/screens/admin/order/custom_order.dart';
import 'package:provider/provider.dart';

class OrderListView extends StatefulWidget {
  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderAdmin>>(context);
    return order == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            itemCount: order.length,
            itemBuilder: (context, index) {
              return CustomOrder(order: order[index]);
            });
  }
}
