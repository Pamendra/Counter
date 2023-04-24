import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('user_logged_in') ?? false;
    return isLoggedIn;
  }
  void setUserLoggedIn(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', status);
  }

  Future<bool> logoutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('user_logged_in', false);
      prefs.setString('user_session_start', '');

      return true;
    } catch (e) {
      return false;
    }
  }

  void setUserID(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userID);
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_id') ?? "";
  }

  void setUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_password', password);
  }

  getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_password') ?? "";
  }

  void setUserId(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userID);
  }

  getUsererId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "";
  }
}
