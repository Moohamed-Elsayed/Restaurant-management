import 'package:cloud_firestore/cloud_firestore.dart';

class OrderAdmin {
  String _nameTable;
  int _totalCount;
  double _totalPrice;
  List _orderList = [];
  Timestamp _createdAt;
  String _idOrder;
  double _rating;

  OrderAdmin();

  OrderAdmin.insert(this._nameTable, this._totalCount, this._totalPrice,
      this._orderList, this._rating);

  OrderAdmin.fromMap(Map<dynamic, dynamic> data) {
    _nameTable = data['nameTable'];
    _totalCount = data['totalCount'];
    _totalPrice = data['totalPrice'];
    _orderList = data['orderList'];
    _createdAt = data['createdAt'];
    _idOrder = data['idOrder'];
    _rating = data['rating'];
  }

  Map<String, dynamic> toMap() {
    return {
      'nameTable': _nameTable,
      'totalCount': _totalCount,
      'totalPrice': _totalPrice,
      'orderList': _orderList,
      'createdAt': _createdAt,
      'idOrder': _idOrder,
      'rating': _rating
    };
  }

  String get nameTable => _nameTable;

  @override
  String toString() {
    return 'OrderAdmin{_nameTable: $_nameTable, _totalCount: $_totalCount, _totalPrice: $_totalPrice, _orderList: $_orderList, _createdAt: $_createdAt, _idOrder: $_idOrder, _rating: $_rating}';
  }

  int get totalCount => _totalCount;

  double get totalPrice => _totalPrice;

  List get orderList => _orderList;

  Timestamp get createdAt => _createdAt;

  String get idOrder => _idOrder;

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  set idOrder(String value) {
    _idOrder = value;
  }

  set createdAt(Timestamp value) {
    _createdAt = value;
  }

  set orderList(List value) {
    _orderList = value;
  }

  set totalPrice(double value) {
    _totalPrice = value;
  }

  set totalCount(int value) {
    _totalCount = value;
  }

  set nameTable(String value) {
    _nameTable = value;
  }
}
