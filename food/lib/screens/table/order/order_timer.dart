import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/table/main_table.dart';
import 'package:food/screens/table/order/avater_and_text.dart';
import 'package:food/screens/table/order/progress_bar.dart';
import 'package:food/screens/table/order/timer.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTimer extends StatefulWidget {
  final idOrder;
  OrderTimer({this.idOrder});
  @override
  _OrderTimerState createState() => _OrderTimerState();
}

class _OrderTimerState extends State<OrderTimer> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    String id = widget.idOrder;
//    WillPopScope
    return StreamBuilder<OrderUpload>(
      stream: OrderDataBase(idOrder: id).currentOrder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          OrderUpload order = snapshot.data;

          return WillPopScope(
            onWillPop: () => null,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Order',
                  style: GoogleFonts.chewy(
                      textStyle:
                          TextStyle(color: Colors.black, fontSize: 30.0)),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 7.0),
                        child: Text(
                          'Order: #${id.substring(0, 4)}',
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                      ),
                      Timer(),
                      ProgressBar(),
                      SizedBox(height: 50.0),
                      AvatarAndText(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar(
                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                            }
                          },
                          onRatingUpdate: (rating) {
                            _rating = rating;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: OutlineButton(
                          borderSide: BorderSide(width: 1.0, color: kBlue),
                          color: kBlue,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 50),
                                Text(
                                  'Finish Order',
                                  style: TextStyle(fontSize: 15, color: kBlue),
                                ),
                                SizedBox(width: 50),
                              ],
                            ),
                          ),
                          onPressed: () => _finishOrder(order),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(height: 0, width: 0);
        }
      },
    );
  }

  _finishOrder(OrderUpload order) async {
    // create  object
    OrderAdmin orderAdmin = OrderAdmin.insert(order.nameTable, order.totalCount,
        order.totalPrice, order.orderList, _rating);
    // database order
    OrderDataBase _order = OrderDataBase();
    await _order.uploadOrderAdmin(orderAdmin);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainTable()), (route) => false);
  }
}
