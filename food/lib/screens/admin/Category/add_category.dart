import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Category.dart';
import 'package:food/service/food_database.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  static const id = 'AddCategory';
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File _imageFile;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  FoodDatabase _database = FoodDatabase();
  Category category = Category();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      backgroundColor: kBackgroundAdmin,
      appBar: AppBar(
        backgroundColor: kBackgroundAdminLight,
        title: Text('Add Category'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
            child: Form(
              key: _keyForm,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _showImage(),
                  SizedBox(height: 16.0),
                  _imageFile == null
                      ? RaisedButton.icon(
                          color: kBackgroundAdminMoreLight,
                          onPressed: () => _getLocalImage(),
                          icon: Icon(Icons.add_photo_alternate,
                              size: 40.0, color: Colors.white),
                          label: Text('Add Image',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)))
                      : SizedBox(height: 0),
                  _textFieldNameFood(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Opacity(
        opacity: keyboardIsOpened ? 0 : 1,
        child: keyboardIsOpened
            ? SizedBox(height: 0)
            : FloatingActionButton(
                onPressed: () => _saveFood(context),
                backgroundColor: kBackgroundAdminLight,
                child: Icon(Icons.save, size: 30.0),
              ),
      ),
    );
  }

  _showImage() {
    if (_imageFile == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Image.asset(
          'images/select_image_food.png',
          height: 100.0,
          width: double.infinity,
          fit: BoxFit.scaleDown,
        ),
      );
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16.0),
            color: Colors.black54,
            onPressed: () => _getLocalImage(),
            child: Text('Change Image',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      );
    }
  }

  // get image from gallery
  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: double.infinity);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  // Input Name Food
  Widget _textFieldNameFood() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        initialValue: '',
        decoration: kInputTextField
            .copyWith(hintText: 'Name Category')
            .copyWith(
                errorStyle: TextStyle(fontSize: 15.0, color: Colors.white)),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        validator: (value) {
          if (value.isEmpty) {
            return 'Category  name Food is required';
          }
          if (value.length < 3 || value.length > 20) {
            return 'Category name must be more than 3 and less than 20';
          }
          return null;
        },
        onSaved: (value) {
          category.nameCategory = value;
        },
      ),
    );
  }

  // saved Category
  _saveFood(BuildContext context) {
    if (!_keyForm.currentState.validate()) {
      return;
    }
    _keyForm.currentState.save();

    _database.uploadCategoryAndImage(category, _imageFile);
    Navigator.of(context).pop();
  }
}
