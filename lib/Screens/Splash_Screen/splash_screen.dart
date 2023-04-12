import 'dart:async';
import 'package:counter/Screens/Login%20Screen/login_screen.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:lottie/lottie.dart';
import 'package:counter/Screens/Service_List.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1600), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  const LoginPage()));
    });
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
}