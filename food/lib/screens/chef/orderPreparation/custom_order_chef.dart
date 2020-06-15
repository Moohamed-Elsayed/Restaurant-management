import 'package:flutter/material.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/chef/order/detalis_order.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOrderChefPreparation extends StatefulWidget {
  final OrderUpload order;

  CustomOrderChefPreparation({this.order});

  @override
  _CustomOrderChefPreparationState createState() =>
      _CustomOrderChefPreparationState();
}

class _CustomOrderChefPreparationState
    extends State<CustomOrderChefPreparation> {
  @override
  Widget build(BuildContext context) {
    var order = widget.order;

    return Dismissible(
      key: new Key(order.idOrder.toString()),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailOrderChef(order: order, displayIconBottom: 0.0)));
        } else {
          return OrderDataBase().deleteOrderChef(order.idOrder);
        }
      },
      onDismissed: (direction) async {},
      child: Card(
        color: Colors.white,
        elevation: 10.0,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CircleAvatar(
                child: Text(
                    'T ${order.nameTable.substring(order.nameTable.length - 1)}'),
              ),
            ),
          ),
          title: Text(
            order.nameTable,
            style: GoogleFonts.notoSerif(
                textStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'count : ${order.totalCount}',
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Text('Total Price :  ${order.totalPrice}',
                  style: GoogleFonts.kanit(
                      textStyle:
                          TextStyle(fontSize: 15.0, color: Colors.green[700])))
            ],
          ),
        ),
      ),
    );
  }

  //  remove slide
  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

// edit slide
  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.remove_red_eye,
              color: Colors.white,
            ),
            Text(
              " View",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
