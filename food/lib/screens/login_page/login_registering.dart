import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food/constant/constant.dart';
import 'package:food/model/User.dart';
import 'package:food/screens/routes_role/wrapper.dart';
import 'package:food/service/auth.dart';
import 'package:food/shared/loading.dart';
import 'package:food/style/theme.dart' as Theme;
import 'package:food/utils/bubble_indication_painter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final userAccess;
  Login({@required this.userAccess});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  //  Firebase  Auth
  final AuthService _auth = AuthService();
  //  Object user
  User user = User();
  // key for form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyNew = GlobalKey<FormState>();
  // focus keyboard
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  // check confirm password
  TextEditingController signupPasswordController = new TextEditingController();
  // show password
  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  // select page
  PageController _pageController;
  bool loading = false;
  Color left = Colors.black;
  Color right = Colors.white;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return userProvider == null
        ? Scaffold(
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 900.0
                      ? MediaQuery.of(context).size.height
                      : 900.0,
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
                  child: loading
                      ? Loading()
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 75.0),
                              child: Image.asset(
                                'images/sign.png',
                                width: 250.0,
                                height: 191.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: _buildMenuBar(context),
                            ),
                            Expanded(
                                flex: 2,
                                child: PageView(
                                  controller: _pageController,
                                  onPageChanged: (i) {
                                    if (i == 0) {
                                      setState(() {
                                        right = Colors.white;
                                        left = Colors.black;
                                      });
                                    } else if (i == 1) {
                                      setState(() {
                                        right = Colors.black;
                                        left = Colors.white;
                                      });
                                    }
                                  },
                                  children: <Widget>[
                                    ConstrainedBox(
                                        constraints:
                                            const BoxConstraints.expand(),
                                        child: _buildSignIn(context)),
                                    new ConstrainedBox(
                                      constraints:
                                          const BoxConstraints.expand(),
                                      child: _buildSignUp(context),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                ),
              ),
            ),
          )
        : Wrapper();
  }

  //  menu bar
  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(color: left, fontSize: 16.0),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(color: right, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // click on button Existing
  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

// click on button new
  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  // sign in
  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 250.0,
                  child: Form(
                    autovalidate: true,
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (value) =>
                                setState(() => user.email = value),
                            validator: (value) {
                              if (value.isEmpty) {
                                return widget.userAccess == 'Table'
                                    ? 'Name Table  is Required'
                                    : 'Email is Required';
                              }

                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return widget.userAccess == 'Table'
                                    ? 'Please enter a valid Table  '
                                    : 'Please enter a valid email address';
                              }

                              return null;
                            },
                            focusNode: myFocusNodeEmailLogin,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: widget.userAccess == 'Table'
                                  ? 'T1@nameCompany.com'
                                  : "Email Address",
                              hintStyle: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (value) =>
                                setState(() => user.password = value),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 5 || value.length > 20) {
                                return 'Password must be betweem 5 and 20 characters';
                              }
                              return null;
                            },
                            focusNode: myFocusNodePasswordLogin,
                            obscureText: _obscureTextLogin,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(FontAwesomeIcons.lock,
                                  size: 22.0, color: Colors.black),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 230.0),
                decoration: kBoxButton,
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    onPressed: () => _sginIn()),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
        ],
      ),
    );
  }

  // build  signUP
  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 450.0,
                  child: Form(
                    key: _formKeyNew,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (value) =>
                                setState(() => user.displayName = value),
                            validator: (value) {
                              if (value.isEmpty) {
                                return widget.userAccess == 'Table'
                                    ? 'Number Table is Required'
                                    : 'name is Required';
                              }
                              if (widget.userAccess == 'Table') {
                              } else {
                                if (value.length < 5 || value.length > 20) {
                                  return 'name must be betweem 5 and 20 characters';
                                }
                              }

                              return null;
                            },
                            focusNode: myFocusNodeName,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: widget.userAccess == 'Table'
                                  ? 'Number Table '
                                  : "UserName",
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (value) =>
                                setState(() => user.email = value),
                            validator: (value) {
                              if (value.isEmpty) {
                                return widget.userAccess == 'Table'
                                    ? 'Name Table  is Required'
                                    : 'Email is Required';
                              }

                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return widget.userAccess == 'Table'
                                    ? 'Please enter a valid Table  '
                                    : 'Please enter a valid email address';
                              }

                              return null;
                            },
                            focusNode: myFocusNodeEmailLogin,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: widget.userAccess == 'Table'
                                  ? 'T1@nameCompany.com'
                                  : "Email Address",
                              hintStyle: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (value) =>
                                setState(() => user.password = value),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 5 || value.length > 20) {
                                return 'Password must be betweem 5 and 20 characters';
                              }
                              return null;
                            },
                            controller: signupPasswordController,
                            focusNode: myFocusNodePasswordLogin,
                            obscureText: _obscureTextSignup,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(FontAwesomeIcons.lock,
                                  size: 22.0, color: Colors.black),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  _obscureTextSignup
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (signupPasswordController.text != value) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            obscureText: _obscureTextSignupConfirm,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Confirmation",
                              hintStyle: TextStyle(fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignupConfirm,
                                child: Icon(
                                  _obscureTextSignupConfirm
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 430.0),
                decoration: kBoxButton,
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                    onPressed: () => _register()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
  }

  //  show password eys
  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  // Firebase
  _register() async {
    if (_formKeyNew.currentState.validate()) {
      _formKeyNew.currentState.save();
      setState(() => loading = true);
      dynamic result =
          await _auth.registerWithEmailAndPassword(user, widget.userAccess);

      if (result != null) {
        setState(() => loading = false);
      } else {
        setState(() => loading = false);
      }
    }
  }

  _sginIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() => loading = true);
      dynamic result =
          await _auth.sginInWithEmailAndPassword(user, widget.userAccess);
      if (result != null) {
        setState(() => loading = false);
      } else {
        setState(() => loading = false);
      }
    }
  }
}
