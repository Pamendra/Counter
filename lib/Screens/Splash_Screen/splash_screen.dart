import 'dart:async';
import 'package:counter/Screens/Login%20Screen/login_screen.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:counter/Screens/Service_List.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "Login";

Trainlistdb() async {
  /// Clear Train list
  final Database database = await openDatabase('my_database.db');
  // Delete the database
  await database.close();
  await deleteDatabase('my_database.db');
  await Utils().getUsererId();
}

  // startSplashScreen() async {
  //   var duration = const Duration(seconds: 4);
  //   return Timer(duration, () async {
  //     bool isLogin = await Utils().getUserLoggedIn();
  //     if (isLogin) {
  //       Navigator.of(context).pushReplacement(
  //                       MaterialPageRoute(
  //                           builder: (BuildContext context) => const Station()));
  //     } else {
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                     builder: (BuildContext context) =>  const LoginPage()));
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Trainlistdb();
    // Timer(const Duration(milliseconds: 1600), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) =>  const LoginPage()));
    // });
    wheretogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: gradient_login,
        child: Center(
            child: Lottie.asset(
              'assets/animations/trac.json',
              frameRate: FrameRate.max,
            )),
      ),
    );
  }

  void wheretogo() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool(KEYLOGIN);


    Timer( Duration(milliseconds:1300), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const Station()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()));
        }
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  const LoginPage()));
      }
    });
  }

}