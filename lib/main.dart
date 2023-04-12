import 'package:counter/Bloc/Login_Bloc/LoginBloc.dart';
import 'package:counter/Screens/Splash_Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<LoginBloc>(
        create: (context) => LoginBloc()),
    ],
    child: Sizer(builder: (context, orientation, deviceType){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }));
  }
}

