import 'package:flutter/material.dart';
import 'package:food/model/NameCategory.dart';
import 'package:food/model/User.dart';
import 'package:food/screens/admin/Category/CategoryFood/add_food_category.dart';
import 'package:food/screens/admin/Category/add_category.dart';
import 'package:food/screens/admin/Category/view_category.dart';
import 'package:food/screens/admin/Food/create_food.dart';
import 'package:food/screens/admin/Food/view_food.dart';
import 'package:food/screens/admin/foodTrending/add_trending.dart';
import 'package:food/screens/admin/foodTrending/view_trending.dart';
import 'package:food/screens/admin/main_admin.dart';
import 'package:food/screens/admin/order/view_order.dart';
import 'package:food/screens/chef/main-chef.dart';
import 'package:food/screens/routes_role/wrapper.dart';
import 'package:food/service/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
          create: (context) => NameCategory(), child: MyApp()),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
        routes: {
          MainAdmin.id: (context) => MainAdmin(),
          MainChef.id: (context) => MainChef(),
          ManageFood.id: (context) => ManageFood(),
          CreateFood.id: (context) => CreateFood(),
          ViewTrending.id: (context) => ViewTrending(),
          AddTrending.id: (context) => AddTrending(),
          ViewCategory.id: (context) => ViewCategory(),
          AddCategory.id: (context) => AddCategory(),
          AddFoodCategory.id: (context) => AddFoodCategory(),
          ViewOrder.id: (context) => ViewOrder()
        },
      ),
    );
  }
}
