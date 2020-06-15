import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/model/User.dart';
import 'package:food/shared/sharedPref.dart';

class AuthService {
  // create auth object
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create Access
  final SharedPref _shared = SharedPref();

  // ! create user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // ! auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in  with email and password
  Future sginInWithEmailAndPassword(User user, String access) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: user.email.trim(), password: user.password.trim());

      FirebaseUser currentUser = result.user;
      if (currentUser != null) {
        await _shared.setAccessFormSharedPref(access);
        return _userFromFirebaseUser(currentUser);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // * register with email & password
  Future registerWithEmailAndPassword(User user, String access) async {
    try {
      AuthResult result = await _auth
          .createUserWithEmailAndPassword(
              email: user.email.trim(), password: user.password.trim())
          .catchError((err) => print(err.code));

      if (result != null) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = user.displayName.trim();
        FirebaseUser firebaseUser = result.user;
        if (firebaseUser != null) {
          await firebaseUser.updateProfile(updateInfo);
          await firebaseUser.reload();
          await _shared.setAccessFormSharedPref(access);
          FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
          return _userFromFirebaseUser(currentUser);
        }
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // * sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
