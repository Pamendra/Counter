import 'package:counter/Bloc/Login_Bloc/LoginBloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_bloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_event.dart';
import 'package:counter/Bloc/ServiceData/ServiceBloc.dart';
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
          BlocProvider<NetworkBloc>(
              create: (context) => NetworkBloc()..add(NetworkObserve()), lazy: false),
        BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),lazy: false),
          BlocProvider<ServiceBloc>(
              create: (context) => ServiceBloc()),
    ],
    child: Sizer(builder: (context, orientation, deviceType){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }));
  }
}

