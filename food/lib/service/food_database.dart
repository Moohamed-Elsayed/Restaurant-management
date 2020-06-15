import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food/constant/database.dart';
import 'package:food/model/Category.dart';
import 'package:food/model/Food.dart';
import 'package:food/model/Trending.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class FoodDatabase {
  // collection reference Foods
  final CollectionReference foodRef =
      Firestore.instance.collection(kCollectionFood);
  // Collections reference Trending
  final CollectionReference trendingRef =
      Firestore.instance.collection(kCollectionTrending);
  // Collection reference  Category
  final CollectionReference categoryRef =
      Firestore.instance.collection(kCollectionCategory);
  // id food current
  final idFood;
  final nameCategory;
  FoodDatabase({this.idFood, this.nameCategory});

  // upload Image  to Storage
  uploadFoodAndImage(Food food, File localFile, bool isUpdating) async {
    if (localFile != null) {
      var fileExtension = p.extension(localFile.path);
      var uuid = Uuid().v4();
      final StorageReference firebaseStorageRrf = FirebaseStorage.instance
          .ref()
          .child('$kStorageImageFoodsPath$uuid$fileExtension');

      await firebaseStorageRrf.putFile(localFile).onComplete.catchError((err) {
        print(err);
        return false;
      });
      String url = await firebaseStorageRrf.getDownloadURL();
      _uploadFood(food, isUpdating, imageUrl: url);
    } else {
      _uploadFood(food, isUpdating);
    }
  }

  //  upload  data to database
  _uploadFood(Food food, bool isUpdating, {String imageUrl}) async {
    if (imageUrl != null) {
      food.image = imageUrl;
    }

    if (isUpdating) {
      food.updateAt = Timestamp.now();
      await foodRef.document(food.id).updateData(food.toMap());
    } else {
      food.createdAt = Timestamp.now();
      DocumentReference documentRef = await foodRef.add(food.toMap());
      food.id = documentRef.documentID;
      await documentRef.setData(food.toMap(), merge: true);
    }
  }

  // delete  Food
  deleteFood(Food food) async {
    if (food.image != null) {
      StorageReference storageReference =
          await FirebaseStorage.instance.getReferenceFromUrl(food.image);
      await storageReference.delete();
    }
    await foodRef.document(food.id).delete();
  }

  //  get Data from Foods  collection
  List<Food> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Food.fromMap(doc.data);
    }).toList();
  }

  // * get Food stream
  Stream<List<Food>> get foods {
    return foodRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_foodListFromSnapshot);
  }

  //  set data in current food
  Food _currentFoodFromSnapshot(DocumentSnapshot snapshot) {
    return Food.fromMap(snapshot.data);
  }

  //  get current food
  Stream<Food> get currentFood {
    return foodRef.document(idFood).snapshots().map((_currentFoodFromSnapshot));
  }

  //----------------------- Trending -----------------------------

// add Trending
  addFoodToTrending(Trending trending) async {
    await trendingRef.document(kDocumentTrendy).setData(trending.toMap());
  }

  // delete Trending
  deleteFoodFromTrending(String idFood) async {
    dynamic id = idFood;
    List<dynamic> list = [];
    list.add(id);
    await trendingRef
        .document(kDocumentTrendy)
        .updateData({kFieldIdList: FieldValue.arrayRemove(list)});
  }

  // set data to Trending
  Trending _allDataFromSnapshot(DocumentSnapshot snapshot) {
    return Trending.fromMap(snapshot.data);
  }

  // get Data Trending
  Stream<Trending> get trendingList {
    return trendingRef
        .document(kDocumentTrendy)
        .snapshots()
        .map(_allDataFromSnapshot);
  }

  //-----------------------------------------Category--------------------------------------

// upload Image  Category to Storage
  uploadCategoryAndImage(Category category, File localFile) async {
    if (localFile != null) {
      var fileExtension = p.extension(localFile.path);
      var uuid = Uuid().v4();
      final StorageReference firebaseStorageRrf = FirebaseStorage.instance
          .ref()
          .child(
              '$kStorageImageCategoryPath/${category.nameCategory}/images/$uuid$fileExtension');

      await firebaseStorageRrf.putFile(localFile).onComplete.catchError((err) {
        print(err);
        return false;
      });
      String url = await firebaseStorageRrf.getDownloadURL();
      _uploadCategory(category, imageUrl: url);
    }
  }

// upload  Category
  _uploadCategory(Category category, {String imageUrl}) async {
    if (imageUrl != null) {
      category.image = imageUrl;
    }

    category.createdAt = Timestamp.now();
    String nameFiled = category.nameCategory;
    await categoryRef.document(nameFiled).setData(category.toMap());
  }

  //  get Data from Category  collection
  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Category.fromMap(doc.data);
    }).toList();
  }

  // * get Category stream
  Stream<List<Category>> get category {
    return categoryRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_categoryListFromSnapshot);
  }

  // set current  Category
  Category _currentCategoryFromSnapshot(DocumentSnapshot snapshot) {
    return Category.fromMap(snapshot.data);
  }

  // get Data Category
  Stream<Category> get categoryData {
    return categoryRef
        .document(nameCategory)
        .snapshots()
        .map(_currentCategoryFromSnapshot);
  }

  // add Category  Food
  addFoodToCategory(Category category, String nameCategory) async {
    await categoryRef.document(nameCategory).setData(category.toMap());
  }

  // delete Trending
  deleteFoodFromCategory(String idFood, String nameCategory) async {
    dynamic id = idFood;
    List<dynamic> list = [];
    list.add(id);
    await categoryRef
        .document(nameCategory)
        .updateData({kFieldIdList: FieldValue.arrayRemove(list)});
  }
}
