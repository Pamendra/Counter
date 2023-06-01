// ignore_for_file: use_build_context_synchronously
import 'package:counter/Bloc/Login_Bloc/LoginBloc.dart';
import 'package:counter/Bloc/Login_Bloc/LoginEvent.dart';
import 'package:counter/Bloc/Login_Bloc/LoginState.dart';
import 'package:counter/Bloc/NetworkBloc/network_bloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_state.dart';
import 'package:counter/Screens/Splash_Screen/splash_screen.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Utils/SizedSpace.dart';
import 'package:counter/Utils/dialogs_utils.dart';
import 'package:counter/Utils/drawer_login.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Utils/utils.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/colors_constants.dart';
import '../../utils/ApploadingBar.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  String logout = 'not logged In';



  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    Utils().setUserId(logout);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
    child: Scaffold(

      drawer:  DrawerLogin(),
      appBar: AppBar(
        backgroundColor: ColorConstants.appcolor,
        actions: [
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  state is NetworkFailure ? Icons.cloud_off : Icons.cloud_done,
                  size: 35,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: 1000.h,
        decoration: gradient_login,
          child: BlocConsumer<LoginBloc,LoginState>(
        listener: (context,state){
          if(state is LoginSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>  const Station()), (route) => false);
          }else if(state is LoginErrorState){
             Dialogs.showValidationMessage(context, state.error);
          }
        },builder: (context,state){
         return ModalProgressHUD(
           color: Colors.white,
           opacity: .1,
           progressIndicator: const LoadingBar(),
           inAsyncCall: state is LoginLoadingState ? true : false,
           child: Padding(
             padding:  EdgeInsets.only(top: 10.sp,right: 16.sp,left: 16.sp),
             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Column(
                 children: [
                   Image.asset('assets/images/pcds.webp'),
                    Text('Counter App',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24.sp,color: ColorConstants.appcolor),),
                   LargeSpace(),
                   Row(
                     children: [
                       Container(
                           padding: EdgeInsets.only(left: 2.sp),
                           child:headingText(title: 'Username or User ID',)
                       ),
                     ],
                   ),
                   SmallSpace(),
                   SizedBox(
                     width: 95.w,
                     height: 6.5.h,
                     child: TextFormField(
                       controller: emailController,
                       decoration: InputDecoration(
                         focusedBorder: OutlineInputBorder(
                           borderSide:  BorderSide(width: 3,color: ColorConstants.primaryColor),
                           borderRadius: BorderRadius.circular(5)
                         ),
                           filled: true,
                           fillColor: Colors.white,
                           hintText: 'Username',
                           hintStyle: const TextStyle(color: Colors.black54),
                           suffixIcon: const Icon(Icons.person,color:  Color(0xFF202447),),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5))),
                     ),
                   ),
                   MediumSpace(),
                   Row(
                     children: [
                       Container(
                           padding: EdgeInsets.only(left: 2.sp),
                           child:headingText(title: 'Password',)
                       ),
                     ],
                   ),
                   SmallSpace(),
                   SizedBox(
                     width: 95.w,
                     height: 6.5.h,
                     child: TextFormField(
                       controller: passwordController,
                       obscureText: !_passwordVisible,
                       decoration: InputDecoration(
                           focusedBorder: OutlineInputBorder(
                               borderSide:  BorderSide(width: 3,color: ColorConstants.primaryColor),
                               borderRadius: BorderRadius.circular(5)
                           ),
                         filled: true,
                           fillColor: Colors.white,
                           hintText: 'Password',
                           hintStyle: const TextStyle(color: Colors.black54),

                           suffixIcon: IconButton(
                             icon: Icon(
                               _passwordVisible
                                   ? Icons.visibility
                                   : Icons.visibility_off,
                               color: const Color(0xFF202447),
                             ),
                             onPressed: () {
                               setState(() {
                                 _passwordVisible = !_passwordVisible;
                               });
                             },
                           ),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5))),
                     ),
                   ),
                   LargeSpace(),
                   SizedBox(width: 95.w,height: 6.h,
                       child: ElevatedButton(onPressed: () async {
                         if (emailController.text.isEmpty) {
                          Dialogs.showValidationMessage(context, 'Please enter username');
                         } else if (passwordController.text.isEmpty) {
                           Dialogs.showValidationMessage(context, 'Please enter password');

                         } else  {
                           BlocProvider.of<LoginBloc>(context).add(
                               LoginPressedEvent(emailController.text, passwordController.text));
                           Utils().setUserId(emailController.text);
                           var sharedpref = await SharedPreferences.getInstance();
                           sharedpref.setBool(SplashScreenState.KEYLOGIN, true);
                         }
                       },style: ElevatedButton.styleFrom(
                           backgroundColor: ColorConstants.appcolor
                       ), child:  Text('Sign In',style: TextStyle(fontSize: 12.sp,fontWeight:FontWeight.w700,fontFamily: "railBold"),)))
                 ],
               ),
             ),
           ),
         );
        },
        ),
      ))
    );
  }
}
