import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/model/Food.dart';
import 'package:food/screens/table/Trending/custom_Trending.dart';
import 'package:provider/provider.dart';

class ListViewTrending extends StatefulWidget {
  @override
  _ListViewTrendingState createState() => _ListViewTrendingState();
}

class _ListViewTrendingState extends State<ListViewTrending> {
  @override
  Widget build(BuildContext context) {
    final foodList = Provider.of<List<Food>>(context);
    return foodList == null
        ? Container(width: 0, height: 0)
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return CustomTrending(food: foodList[index]);
            });
  }
}
