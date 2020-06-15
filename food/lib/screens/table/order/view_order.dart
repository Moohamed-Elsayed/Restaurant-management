import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/db/database_helper.dart';
import 'package:food/model/User.dart';
import 'package:food/model/order_list_table.dart';
import 'package:food/model/order_upload.dart';
import 'package:food/service/order_dataBase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqlite_api.dart';

import 'order_timer.dart';

class ViewOrder extends StatefulWidget {
  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  // sqlite
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  List<OrderTable> orderList;
  int count = 0;
  int countAll = 0;
  double totalPrice = 0.0;

  //  dataBase
  OrderDataBase _dataBase = OrderDataBase();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    if (orderList == null) {
      orderList = List<OrderTable>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Order',
          style: GoogleFonts.chewy(
              textStyle: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
        centerTitle: true,
      ),
      body: _getOrderListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white30,
        onPressed: () => _uploadOrder(currentUser.displayName), //  name table
        child: Image.asset(
          'images/order_finsh.png',
          width: 40,
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
                  'count Total :  ${countAll ?? 0}',
                  style: GoogleFonts.quattrocento(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15.0)),
                ),
                Text(
                  'price Total : ${totalPrice ?? 0.0} JD ',
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

// create list view
  Widget _getOrderListView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) {
            return Dismissible(
              key: new Key(orderList[position].id.toString()),
              background: slideRightBackground(), // delete
              secondaryBackground: slideLeftBackground(), // edit
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  try {
                    int result = await dataBaseHelper
                        .deleteOrder(orderList[position].id);
                    if (result != 0) {
                      updateListView();
                    }
                  } catch (err) {
                    debugPrint(err);
                  }
                  return true;
                } else {
                  return false;
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
                      child: Image.network(
                        orderList[position].image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    orderList[position].nameFood,
                    style: GoogleFonts.notoSerif(
                        textStyle: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500)),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Count : ${orderList[position].count}',
                        style: GoogleFonts.oswald(
                            textStyle: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Text('Total Price :  ${orderList[position].totalPrice}',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.green[700])))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // update  ui
  void updateListView() {
    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<OrderTable>> orderListFuture = dataBaseHelper.getOrderList();
      orderListFuture.then((orderList) {
        setState(() {
          this.orderList = orderList;
          this.count = orderList.length;
        });
      });
    });
    _getCount();
    _getTotalPrice();
  }

  // get  all count
  _getCount() {
    Future<int> countAll = dataBaseHelper.getCountAll();
    countAll.then((value) {
      setState(() {
        this.countAll = value;
      });
    });
  }

// get total price
  _getTotalPrice() {
    Future<double> countAll = dataBaseHelper.getTotalPrice();
    countAll.then((value) {
      setState(() {
        this.totalPrice = value;
      });
    });
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
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
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

  _uploadOrder(String nameTable) async {
    // ? v.v.v.imp  orderList include  object from TableOrder  when need storage in other array need convert (map)
    OrderUpload order =
        OrderUpload.insert('Table $nameTable', countAll, totalPrice);

    orderList.forEach((element) {
      order.addOrder(element.toMap());
    });

    String idOrder = await _dataBase.uploadOrder(order);
    // delete all  order in storage local
    dataBaseHelper.deleteAllOrder();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => OrderTimer(
                  idOrder: idOrder,
                )),
        (route) => false);
  }
}
