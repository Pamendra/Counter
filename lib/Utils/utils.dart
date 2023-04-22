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

  void setUserId(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userID);
  }

  getUsererId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('username') ?? "";
  }
}
