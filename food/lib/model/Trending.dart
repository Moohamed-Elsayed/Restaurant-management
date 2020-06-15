class Trending {
  List idList = [];

  Trending({this.idList});

  Trending.fromMap(Map<dynamic, dynamic> data) {
    idList = data['idList'];
  }

  Map<String, dynamic> toMap() {
    return {'idList': idList};
  }
}
