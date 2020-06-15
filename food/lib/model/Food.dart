import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String image;
  double price;
  List subIngredients = [];
  Timestamp createdAt;
  Timestamp updateAt;

  Food();
  // dart
  Food.fromMap(Map<dynamic, dynamic> data) {
    id = data['id'];
    name = data['name'];
    price = data['price'];
    image = data['image'];
    subIngredients = data['subIngredients'];
    createdAt = data['createdAt'];
    updateAt = data['updateAt'];
  }
// json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price ?? 0.0,
      'image': image,
      'subIngredients': subIngredients,
      'createdAt': createdAt,
      'updateAt': updateAt
    };
  }
}
