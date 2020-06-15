import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/login_page/login_registering.dart';
import 'package:food/style/theme.dart' as Theme;

class SelectRole extends StatefulWidget {
  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 500),
                text: ["Select Rules"],
                textStyle:
                    TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CardRole(nameRole: 'Admin', imageRole: 'images/admin.png'),
                  CardRole(nameRole: 'Chef', imageRole: 'images/chef.png'),
                  CardRole(nameRole: 'Table', imageRole: 'images/table.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardRole extends StatelessWidget {
  final nameRole;
  final imageRole;

  CardRole({this.nameRole, this.imageRole});

  // create card for access
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Login(
                userAccess: nameRole,
              ))),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10.0)),
        borderOnForeground: true,
        child: Column(
          children: <Widget>[
            Image.asset(
              imageRole,
              width: screenSize.width / 4,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(nameRole,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ),
    );
  }
}
