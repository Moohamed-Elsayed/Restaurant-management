import 'package:flutter/material.dart';
import 'package:food/model/order_upload.dart';
import 'package:provider/provider.dart';

import 'custom_order_chef.dart';

class ListViewChef extends StatefulWidget {
  @override
  _ListViewChefState createState() => _ListViewChefState();
}

class _ListViewChefState extends State<ListViewChef> {
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
              return CustomOrderChefPreparation(order: order[index]);
            });
  }
}
