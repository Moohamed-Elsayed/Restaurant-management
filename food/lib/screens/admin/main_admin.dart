import 'package:flutter/material.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/User.dart';
import 'package:food/service/auth.dart';
import 'package:provider/provider.dart';

import 'display_card.dart';

class MainAdmin extends StatefulWidget {
  static const id = 'MainAdmin';

  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: kBackgroundAdmin,
      appBar: AppBar(
        backgroundColor: kBackgroundAdminLight,
        title: Text(
            currentUser != null
                ? currentUser.displayName ?? 'loading.. '
                : 'Admin',
            style: currentUser.displayName == null
                ? TextStyle(color: Colors.blue)
                : TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          RaisedButton.icon(
            color: kBackgroundAdminMoreLight,
            onPressed: () => _auth.signOut(),
            icon: Image.asset(
              'images/logout.png',
              width: 24,
            ),
            label: Text('Logout', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 8),
          GridDashboard(),
        ],
      ),
    );
  }
}
