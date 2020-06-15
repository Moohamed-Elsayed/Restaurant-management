import 'package:flutter/material.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/screens/admin/order/datiels_order.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOrder extends StatefulWidget {
  final OrderAdmin order;

  CustomOrder({this.order});

  @override
  _CustomOrderState createState() => _CustomOrderState();
}

class _CustomOrderState extends State<CustomOrder> {
  @override
  Widget build(BuildContext context) {
    var order = widget.order;

    return Dismissible(
      key: new Key(order.idOrder.toString()),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          try {
            // delete
            OrderDataBase().deleteOrder(order.idOrder);
          } catch (err) {
            debugPrint(err);
          }
          return true;
        } else {
          // view
          return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsOrder(order: order)));
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
                'rating : ${order.rating}',
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

  // edit slide
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

// remove slide
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
