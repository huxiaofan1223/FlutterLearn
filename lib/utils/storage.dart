import 'package:shared_preferences/shared_preferences.dart';

class Storage{
    static Future<void> set(key, value) async{
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(key, value);
    }
    static Future<String> get(key) async{
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.getString(key);
    }
}