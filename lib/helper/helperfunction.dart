import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  //saving data to sharepref
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("current login is ${userEmail}");
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }


  /// geting data from sharedprefs
  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var f = prefs.getBool(sharedPreferenceUserLoggedInKey);
    var len = false;
    if (f != null) {
      var len = f; // Safe 
    }
    else {
      var len = false;
    }
    return  len;
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? f = prefs.getString(sharedPreferenceUserEmailKey);
    
    var len = '';
    if (f != null) {
      len = f; // Safe 
    }
    else {
      len = '';
    }

    return  len;
  }
}