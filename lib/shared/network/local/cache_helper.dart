import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key, required bool value}) async {
    print(' darkmode getdata stateeeee ${value.toString()}');
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getData({required String key})  {
    print(' darkmode getdata stateeeee ${sharedPreferences.getBool(key).toString()}');
    return  sharedPreferences.getBool(key);
  }
}