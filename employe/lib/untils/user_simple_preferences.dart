import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const String isUserLoggedIn = 'isuserloggedin';
  static const String isToken = 'token';
  static const String userDataLocal = 'userData';
  static const String uniquecode = 'uniquecode';


  
/////////////////////////////
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoginStatus({required bool loginStatus}) async {
    await _preferences.setBool(isUserLoggedIn, loginStatus);
  }

  static bool? getLoginStatus() {
    return _preferences.getBool(isUserLoggedIn);
  }

  static Future setUserdata({required String userData}) async {
    await _preferences.setString(userDataLocal, userData);
  }

  static String? getUserdata() {
    return (_preferences.getString(userDataLocal));
  }

static Future setToken({required String token}) async {
  print("Saving token: $token"); 
  await _preferences.setString(isToken, token);
}

static String? getToken() {
  String? token = _preferences.getString(isToken);
  print("Retrieved token: $token"); 
  return token;
}
static String? getuniquecode() {
    return (_preferences.getString(uniquecode));
  }
  static Future<void> clearAllData() async {
  
    String? uniqueCode = getuniquecode();
   
    await _preferences?.clear();

   
    if (uniqueCode != null) {
      await _preferences?.setString('uniquecode', uniqueCode);
    }
  }
}
