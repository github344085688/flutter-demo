import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedSersvers {
  static Object setPreference( String key, Object dataType, Object data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(dataType){
      case bool:
        await prefs.setBool(key, data);
        break;
      case double:
        await prefs.setDouble(key, data);
        break;
      case int:
        await prefs.setInt(key, data);
        break;
      case String:
        await prefs.setString(key, data);
        break;
      case List:
        await prefs.setStringList(key, data);
        break;
      default:
        await prefs.setString(key, data);
        break;
    }

  }
/*
  static Future<Object> getPreference(String key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }*/

  static removePreference(String key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  /*** * 删除指定数据 */
  static void remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<Object>  getPreference( String key, Object dataType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(dataType){
      case bool:
        return prefs.getBool(key);
        break;
      case double:
        return prefs.getDouble(key);
        break;
      case int:
        return prefs.getInt(key);
        break;
      case String:
        return prefs.getString(key);
        break;
      case List:
        return prefs.getStringList(key);
        break;
      default:
        return prefs.getString(key);
        break;
    }
  }

}
