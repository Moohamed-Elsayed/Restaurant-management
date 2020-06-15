import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/model/order_list_table.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/screens/chef/orderPreparation/view_order_preparation.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailOrderChef extends StatefulWidget {
  final OrderUpload order;
  final double displayIconBottom;

  DetailOrderChef({this.order, this.displayIconBottom});

  @override
  _DetailOrderChefState createState() => _DetailOrderChefState();
}

class _DetailOrderChefState extends State<DetailOrderChef> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var order = widget.order;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Order  Details ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                  'T ${order.nameTable.substring(order.nameTable.length - 1)}'),
            ),
          )
        ],
      ),
      body: _viewDataOrder(order, screenWidth, screenHeight),
      floatingActionButton: Opacity(
        opacity: widget.displayIconBottom,
        child: widget.displayIconBottom == 0.0
            ? SizedBox(height: 0)
            : FloatingActionButton(
                backgroundColor: Colors.white30,
                onPressed: () async {
                  // delete from order
                  await OrderDataBase().deleteOrderUser(order.idOrder);
                  // upload order chef
                  await OrderDataBase().uploadOrderChef(order);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderPreparation()));
                },
                child: Image.asset(
                  'images/cooking.png',
                  width: 40,
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        elevation: 5.0,
        child: Container(
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'count Total :  ${order.totalCount ?? 0}',
                  style: GoogleFonts.quattrocento(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15.0)),
                ),
                Text(
                  'price Total : ${order.totalPrice ?? 0.0} JD ',
                  style: GoogleFonts.quattrocento(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _viewDataOrder(OrderUpload order, double width, double height) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          // order id
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
              child: Text('OrderId: #${order.idOrder.substring(0, 8)}',
                  style: TextStyle(color: Colors.black, fontSize: 22.0)),
            ),
          ),
          SizedBox(height: 30.0),
          // list food
          Container(
            width: width / 1,
            height: height,
            child: _buildListFoodOrder(order.orderList, width, height),
          ),
          SizedBox(height: 20.0),
          // rating
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
          String avoidIng =
              orderCurrent.avoidIngredientsList.replaceAll(',', '\n');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
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
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        orderCurrent.nameFood,
                        style: GoogleFonts.courgette(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                backgroundColor: Colors.black26)),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'avoid Ingredients',
                    style: GoogleFonts.actor(
                        textStyle: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(avoidIng),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'count : ${orderCurrent.count ?? 0}',
                    style: GoogleFonts.actor(
                        textStyle: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'price Total : ${orderCurrent.totalPrice ?? 0.0} JD ',
                    style: GoogleFonts.actor(
                        textStyle: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
