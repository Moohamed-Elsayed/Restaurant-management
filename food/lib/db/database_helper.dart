import 'dart:io';

import 'package:food/model/order_list_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

// table info
  String orderTable = 'order_food';
  String colId = 'id';
  String colName = 'nameFood';
  String colImage = 'image';
  String colTotalPrice = 'totalPrice';
  String colCount = 'count';
  String colDate = 'date';
  String colAvoidIngredientsList = 'avoidIngredientsList';

  DataBaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  //this to check if we have init an object in the project
  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      // This is executed only once, singleton object
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'orderfood.db';
    var orderDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return orderDatabase;
  }

  // create database Table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $orderTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colImage TEXT, $colCount INTEGER,$colTotalPrice REAL ,$colDate TEXT,$colAvoidIngredientsList TEXT)');
  }

  // Fetch Operation: Get all order  objects from database
  Future<List<Map<dynamic, dynamic>>> getOrderMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(orderTable, orderBy: '$colName ASC');
    return result;
  }

  // Insert Operation: Insert a order object to database
  Future<int> insertOrder(OrderTable orderTable) async {
    Database db = await this.database;
    var result = await db.insert(this.orderTable, orderTable.toMap());
    return result;
  }

  // Delete Operation: Delete a order object from database
  Future<int> deleteOrder(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $orderTable WHERE $colId = $id');
    return result;
  }

  // Delete Operation: Delete a order object from database
  Future<int> deleteAllOrder() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $orderTable ');
    return result;
  }

  // Get number of order objects in database
  Future<int> getCount() async {
    //instance of Database
    Database db = await this.database;

    //Database Query you store your Query inside this Variable
    List<Map<dynamic, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $orderTable');

    int result = Sqflite.firstIntValue(x);

    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<OrderTable>> getOrderList() async {
    var orderMapList = await getOrderMapList(); // Get 'Map List' from database
    // Count the number of map entries in db table
    int count = orderMapList.length;

    List<OrderTable> orderList = List<OrderTable>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      orderList.add(OrderTable.fromMapObject(orderMapList[i]));
    }

    // import return all  data in list
    return orderList;
  }

  // get sum   count order
  Future<int> getCountAll() async {
    //instance of Database
    Database db = await this.database;

    List<Map<dynamic, dynamic>> x = await db
        .rawQuery('SELECT  SUM($colCount) as TotalCount from $orderTable');

    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // get sum price
  Future<double> getTotalPrice() async {
    //instance of Database
    Database db = await this.database;

    List<Map<dynamic, dynamic>> x = await db
        .rawQuery('SELECT  SUM($colTotalPrice) as TotalPrice from $orderTable');

    double result = x[0]['TotalPrice'];

    return result;
  }
}
