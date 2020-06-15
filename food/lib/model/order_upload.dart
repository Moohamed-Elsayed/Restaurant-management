import 'package:cloud_firestore/cloud_firestore.dart';

class OrderUpload {
  String _nameTable;
  int _totalCount;
  double _totalPrice;
  List _orderList = [];
  Timestamp _createdAt;
  String _idOrder;

  OrderUpload();
  OrderUpload.insert(this._nameTable, this._totalCount, this._totalPrice);
  OrderUpload.fromMap(Map<dynamic, dynamic> data) {
    _nameTable = data['nameTable'];
    _totalCount = data['totalCount'];
    _totalPrice = data['totalPrice'];
    _orderList = data['orderList'];
    _createdAt = data['createdAt'];
    _idOrder = data['idOrder'];
  }

  Map<String, dynamic> toMap() {
    return {
      'nameTable': _nameTable,
      'totalCount': _totalCount,
      'totalPrice': _totalPrice,
      'orderList': _orderList,
      'createdAt': _createdAt,
      'idOrder': _idOrder
    };
  }

  set createdAt(Timestamp value) {
    _createdAt = value;
  }

  set idOrder(String value) {
    _idOrder = value;
  }

  String get idOrder => _idOrder;

  String get nameTable => _nameTable;

  addOrder(Map<dynamic, dynamic> data) {
    _orderList.add(data);
  }

  getOrder() {
    _orderList.forEach((element) {
      print(element);
    });
  }

  @override
  String toString() {
    return 'OrderUpload{_nameTable: $_nameTable, _totalCount: $_totalCount, _totalPrice: $_totalPrice, _orderList: $_orderList, _createdAt: $_createdAt, _idOrder: $_idOrder}';
  }

  int get totalCount => _totalCount;

  double get totalPrice => _totalPrice;

  List get orderList => _orderList;

  Timestamp get createdAt => _createdAt;
}
