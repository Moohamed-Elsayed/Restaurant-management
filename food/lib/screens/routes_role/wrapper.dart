import 'package:flutter/material.dart';
import 'package:food/model/User.dart';
import 'package:food/screens/admin/main_admin.dart';
import 'package:food/screens/chef/main-chef.dart';
import 'package:food/screens/selectRole.dart';
import 'package:food/screens/table/main_table.dart';
import 'package:food/shared/loading.dart';
import 'package:food/shared/sharedPref.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final SharedPref _shared = SharedPref();
  String test;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return SelectRole();
    } else {
      return FutureBuilder<String>(
        future: selectRole(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'Admin') {
              return MainAdmin();
            } else if (snapshot.data == 'Chef') {
              return MainChef();
            } else if (snapshot.data == 'Table') {
              return MainTable();
            }
            return Loading();
          } else {
            return Loading();
          }
        },
      );
    }
  }

  Future<String> selectRole() async {
    String test = await _shared.getAccessFormSharedPref();
    return test;
  }
}
