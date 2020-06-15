import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/constant/database.dart';
import 'package:food/model/OrderAdmin.dart';
import 'package:food/model/order_upload.dart';

class OrderDataBase {
  String idOrder;

  OrderDataBase({this.idOrder});
  // Collection reference  Category
  final CollectionReference orderRef = Firestore.instance.collection(kOrder);
  final CollectionReference orderAdminRef =
      Firestore.instance.collection(kOrderAdmin);
  final CollectionReference orderChef =
      Firestore.instance.collection('OrderChef');

  Future<String> uploadOrder(OrderUpload orderUpload) async {
    orderUpload.createdAt = Timestamp.now();
    DocumentReference documentRef = await orderRef.add(orderUpload.toMap());

    orderUpload.idOrder = documentRef.documentID;
    String id = orderUpload.idOrder;
    await documentRef.setData(orderUpload.toMap(), merge: true);

    return id;
  }

  OrderUpload _currentOrderFromSnapshot(DocumentSnapshot snapshot) {
    return OrderUpload.fromMap(snapshot.data);
  }

  // return one order by id
  Stream<OrderUpload> get currentOrder {
    return orderRef
        .document(idOrder)
        .snapshots()
        .map(_currentOrderFromSnapshot);
  }

  // return all order   collection
  List<OrderUpload> _orderFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OrderUpload.fromMap(doc.data);
    }).toList();
  }

  Stream<List<OrderUpload>> get order {
    return orderRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_orderFromSnapshot);
  }

  // ------------------------------------------ Order Admin --------------------

  Future uploadOrderAdmin(OrderAdmin orderAdmin) async {
    orderAdmin.createdAt = Timestamp.now();
    DocumentReference documentRef = await orderAdminRef.add(orderAdmin.toMap());

    orderAdmin.idOrder = documentRef.documentID;
    await documentRef.setData(orderAdmin.toMap(), merge: true);
  }

  // return all order Admin
  List<OrderAdmin> _orderAdminFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OrderAdmin.fromMap(doc.data);
    }).toList();
  }

  Stream<List<OrderAdmin>> get orderAdmin {
    return orderAdminRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_orderAdminFromSnapshot);
  }

// delete  Food
  deleteOrder(String id) async {
    await orderAdminRef.document(id).delete();
  }

  //---------------------------------------Order Chef -----------------
  Future<String> uploadOrderChef(OrderUpload orderUpload) async {
    orderUpload.createdAt = Timestamp.now();
    DocumentReference documentRef = await orderChef.add(orderUpload.toMap());
    orderUpload.idOrder = documentRef.documentID;
    String id = orderUpload.idOrder;
    await documentRef.setData(orderUpload.toMap(), merge: true);

    return id;
  }

// return all order  chef  collection
  List<OrderUpload> _orderChefFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OrderUpload.fromMap(doc.data);
    }).toList();
  }

  Stream<List<OrderUpload>> get orderChefAllData {
    return orderChef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_orderChefFromSnapshot);
  }

  // delete  order
  deleteOrderUser(String id) async {
    await orderRef.document(id).delete();
  } // delete  order Chef

  deleteOrderChef(String id) async {
    await orderChef.document(id).delete();
  }
}
