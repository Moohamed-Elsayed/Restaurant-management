import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/model/order_list_table.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsOrder extends StatefulWidget {
  final OrderAdmin order;
  DetailsOrder({this.order});

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var order = widget.order;
    return Scaffold(
      backgroundColor: kBackgroundAdmin,
      appBar: AppBar(
        backgroundColor: kBackgroundAdminLight,
        title: Text('Order'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kBackgroundAdminMoreLight,
              child: Text(
                  'T ${order.nameTable.substring(order.nameTable.length - 1)}'),
            ),
          )
        ],
      ),
      body: _viewDataOrder(order, screenWidth, screenHeight),
    );
  }

  _viewDataOrder(OrderAdmin order, double width, double height) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // order id
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
              child: Text('OrderId: #${order.idOrder.substring(0, 8)}',
                  style: TextStyle(color: Colors.white, fontSize: 22.0)),
            ),
          ),
          SizedBox(height: 30.0),
          // list food
          Container(
            width: width / 1,
            height: height / 3,
            child: _buildListFoodOrder(order.orderList, width, height),
          ),
          SizedBox(height: 20.0),
          // rating
          _ratingFood(order.rating),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Count : ${order.totalCount}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text('Total Price : ${order.totalPrice}',
                      style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //  list food
  _buildListFoodOrder(List listOrder, double width, double height) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOrder.length,
        itemBuilder: (context, index) {
          OrderTable orderCurrent = OrderTable.fromMapObject(listOrder[index]);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0)
                      ]),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/loading.gif',
                    placeholderScale: 10,
                    image: orderCurrent.image,
                    fit: BoxFit.fitWidth,
                    height: height / 3,
                    width: width / 1.5,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54])),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Text(
                          orderCurrent.nameFood,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.courgette(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  backgroundColor: Colors.black26)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _ratingFood(double rating) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar(
        initialRating: rating,
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
        onRatingUpdate: (rating) {},
      ),
    );
  }
}
