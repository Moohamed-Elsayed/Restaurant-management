class OrderTable {
  int _id;
  String _nameFood;
  String _image;
  int _count;
  double _totalPrice;
  String _date;
  String _avoidIngredientsList;

  OrderTable(this._nameFood, this._image, this._count, this._totalPrice,
      this._date, this._avoidIngredientsList);

  OrderTable.withId(this._id, this._nameFood, this._image, this._count,
      this._totalPrice, this._date, this._avoidIngredientsList);
// get data

  String get avoidIngredientsList => _avoidIngredientsList;
  String get date => _date;
  double get totalPrice => _totalPrice;

  int get count => _count;

  String get image => _image;

  String get nameFood => _nameFood;

  int get id => _id;

  set date(String value) {
    _date = value;
  } // method set

  set avoidIngredientsList(String value) {
    _avoidIngredientsList = value;
  }

  set totalPrice(double value) {
    _totalPrice = value;
  }

  set count(int value) {
    _count = value;
  }

  set image(String value) {
    _image = value;
  }

  set nameFood(String value) {
    _nameFood = value;
  }

  set id(int value) {
    _id = value;
  }

// Convert a order object into a Map object
  Map<dynamic, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['nameFood'] = _nameFood;
    map['image'] = _image;
    map['count'] = _count;
    map['totalPrice'] = _totalPrice;
    map['date'] = _date;
    map['avoidIngredientsList'] = _avoidIngredientsList;
    return map;
  }

// Extract a order object from a Map object

  OrderTable.fromMapObject(Map<dynamic, dynamic> map) {
    this._id = map['id'];
    this._nameFood = map['nameFood'];
    this._image = map['image'];
    this._count = map['count'];
    this._totalPrice = map['totalPrice'];
    this._date = map['date'];
    this._avoidIngredientsList = map['avoidIngredientsList'];
  }

  @override
  String toString() {
    return 'OrderTable{_id: $_id, _nameFood: $_nameFood, _image: $_image, _count: $_count, _totalPrice: $_totalPrice, _date: $_date, _avoidIngredientsList: $_avoidIngredientsList}';
  }
}
