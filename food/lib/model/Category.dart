import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String nameCategory;
  String image;
  List idList = [];
  Timestamp createdAt;

  Category();
  Category.fromMap(Map<dynamic, dynamic> data) {
    nameCategory = data['nameCategory'];
    image = data['image'];
    idList = data['idList'];
    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'nameCategory': nameCategory,
      'image': image,
      'idList': idList,
      'createdAt': createdAt,
    };
  }
}
