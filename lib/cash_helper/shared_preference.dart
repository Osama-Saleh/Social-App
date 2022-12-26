import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? sharedPreference;

  static Future initialSharedPreference() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    @required key,
    @required value,
  })async {
   if(value is bool) return await sharedPreference!.setBool(key, value);
   return await sharedPreference!.setString(key, value);
   
  }
// static bool? getDataBl({@required String? key}) {
//     return sharedPreference?.getBool(key!);
//   }
  static bool? getDatabl({@required String? key}) {
    return  sharedPreference?.getBool(key!);
  }
  static String? getDataSt({@required String? key}) {
    return  sharedPreference?.getString(key!);
  }
}
