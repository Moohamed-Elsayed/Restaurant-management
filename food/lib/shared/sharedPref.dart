import 'package:food/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future getAccessFormSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final nameAccess = prefs.getString(kNameShared);
    return nameAccess != null ? nameAccess : 'no value';
  }

  Future setAccessFormSharedPref(String access) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kNameShared, access);
  }
}
