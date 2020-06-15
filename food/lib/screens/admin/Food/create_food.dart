import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/Food.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food/service/food_database.dart';

// ignore: must_be_immutable
class CreateFood extends StatefulWidget {
  static const id = 'CreateFood';
  Food currentFood;
  final bool isUpdating;
  CreateFood({this.currentFood, this.isUpdating});
  @override
  _CreateFoodState createState() => _CreateFoodState();
}

class _CreateFoodState extends State<CreateFood> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _subingredientController = TextEditingController();
  FoodDatabase _foodDatabase = FoodDatabase();
  List _subingredients = [];
  String _imageUrl;
  File _imageFile;

  @override
  void initState() {
    super.initState();

    if (widget.currentFood == null) {
      widget.currentFood = Food();
    }
    _subingredients = widget.currentFood.subIngredients;
    _imageUrl = widget.currentFood.image;
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      backgroundColor: kBackgroundAdmin,
      appBar: AppBar(
        backgroundColor: kBackgroundAdminLight,
        title: Text('Create Food'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Center(
            child: Column(
              children: <Widget>[
                _showImage(),
                SizedBox(height: 16.0),
                _imageUrl == null && _imageFile == null
                    ? RaisedButton.icon(
                        color: kBackgroundAdminMoreLight,
                        onPressed: () => _getLocalImage(),
                        icon: Icon(Icons.add_photo_alternate,
                            size: 40.0, color: Colors.white),
                        label: Text('Add Image',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)))
                    : SizedBox(height: 0),
                SizedBox(height: 22.0),
                _textFieldNameFood(),
                SizedBox(height: 22.0),
                _textFieldPriceFood(),
                SizedBox(height: 22.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: _buildSubingredientField()),
                    SizedBox(
                      height: 60.0,
                      child: RaisedButton.icon(
                          color: kBackgroundAdminMoreLight,
                          onPressed: () =>
                              _addSubingredient(_subingredientController.text),
                          icon: Icon(
                            Icons.playlist_add,
                            size: 40,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          )),
                    )
                  ],
                ),
                SizedBox(height: 22.0),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(8),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: _subingredients
                      .map((e) => Card(
                            color: kBackgroundAdminMoreLight,
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
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

  // setting image
  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Image.asset(
        'images/select_image_food.png',
        height: 100.0,
        width: double.infinity,
        fit: BoxFit.scaleDown,
      );
    } else if (_imageFile != null) {
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
    } else if (_imageUrl != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            onPressed: () => _getLocalImage(),
            child: Text(
              'Change Image',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
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
    return TextFormField(
      initialValue:
          widget.currentFood.name != null ? widget.currentFood.name : '',
      decoration: kInputTextField.copyWith(hintText: 'Name Food'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (value) {
        if (value.isEmpty) {
          return 'Name Food is required';
        }
        if (value.length < 3 || value.length > 20) {
          return 'Name must be more than 3 and less than 20';
        }
        return null;
      },
      onSaved: (value) {
        widget.currentFood.name = value;
      },
    );
  }

  //  Input Price  Food
  Widget _textFieldPriceFood() {
    return TextFormField(
      initialValue: widget.currentFood.price != null
          ? widget.currentFood.price.toString()
          : '',
      decoration: kInputTextField.copyWith(hintText: 'Price Food'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      validator: (value) {
        if (value.isEmpty) {
          return 'Price Food is required';
        }
        if (value == '0') {
          return 'price Food must be more 0';
        }
        return null;
      },
      onSaved: (value) {
        widget.currentFood.price = double.tryParse(value.trim()) ?? 0;
      },
    );
  }

  // input for subingredient
  Widget _buildSubingredientField() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextField(
        style: TextStyle(fontSize: 18),
        keyboardType: TextInputType.text,
        controller: _subingredientController,
        decoration: kInputTextField.copyWith(hintText: 'Subingredient'),
      ),
    );
  }

  // add list
  _addSubingredient(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _subingredients.add(text);
      });
      _subingredientController.clear();
    }
  }

  // Save
  _saveFood(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    widget.currentFood.subIngredients = _subingredients;
    _foodDatabase.uploadFoodAndImage(
        widget.currentFood, _imageFile, widget.isUpdating);

    Navigator.of(context).pop();
  }
}
