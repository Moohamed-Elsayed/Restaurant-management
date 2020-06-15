import 'package:flutter/material.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/chef/order/custome_order.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderUpload>>(context);
    return order == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: order.length,
            itemBuilder: (context, index) {
              return CustomOrderChef(order: order[index]);
            });
  }
}
