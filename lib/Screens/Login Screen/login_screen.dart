// ignore_for_file: use_build_context_synchronously
import 'package:counter/Bloc/Login_Bloc/LoginBloc.dart';
import 'package:counter/Bloc/Login_Bloc/LoginEvent.dart';
import 'package:counter/Bloc/Login_Bloc/LoginState.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Utils/dialogs_utils.dart';
import 'package:counter/Utils/drawer_login.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Utils/utils.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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



  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
    child: Scaffold(

      drawer:  DrawerLogin(),
      appBar: AppBar(
        backgroundColor: ColorConstants.appcolor,
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
             padding: const EdgeInsets.only(right: 10,left: 10),
             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Column(
                 children: [
                   Image.asset('assets/images/pcds.webp'),
                   const Text('Counter App',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Color(0xFF202447)),),
                   const SizedBox(height: 40,),
                   Row(
                     children: [
                       Container(
                           padding:const EdgeInsets.only(left: 15),
                           child:headingText(title: 'Username or User ID',)
                       ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
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
                           suffixIcon: const Icon(Icons.email,color:  Color(0xFF202447),),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5))),
                     ),
                   ),
                   const SizedBox(height: 20),
                   Row(
                     children: [
                       Container(
                           padding:const EdgeInsets.only(left: 15),
                           child:headingText(title: 'Password',)
                       ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
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
                   const SizedBox(height: 40,),
                   SizedBox(width: 375,height: 50,
                       child: ElevatedButton(onPressed: () async {
                         if (emailController.text.isEmpty) {
                           showDialog(
                               context: context,
                               builder: (BuildContext context){
                                 return  AlertDialog(
                                   // title: Text("Alert Dialog"),
                                   backgroundColor:const Color(0xFF202447).withOpacity(1),

                                   shape: RoundedRectangleBorder(
                                       side:const BorderSide(color: Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
                                   title: Row(
                                     children: [
                                       const Text('Message',style: TextStyle(color: Colors.white),),
                                      const SizedBox(width: 170,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child:const Icon(Icons.close,color: Colors.white,)),
                                     ],
                                   ),
                                   content:const Text("enter your username or ID",style: TextStyle(color: Colors.white),),
                                 );
                               }
                           );
                         } else if (passwordController.text.isEmpty) {
                           showDialog(
                               context: context,
                               builder: (BuildContext context){
                                 return  AlertDialog(
                                   backgroundColor: const Color(0xFF202447).withOpacity(0.7),
                                   // title: Text("Alert Dialog"),
                                   shape: RoundedRectangleBorder(
                                       side: const BorderSide(color:  Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
                                   title: Row(
                                     children: [
                                       const Text('Message',style: TextStyle(color: Colors.white),),
                                       const SizedBox(width: 170,),
                                       InkWell(
                                           onTap: (){
                                             Navigator.pop(context);
                                           },
                                           child: const Icon(Icons.close,color: Colors.white,)),
                                     ],
                                   ),
                                   content:const Text("enter your password",style: TextStyle(color: Colors.white),),
                                 );
                               }
                           );
                         } else  {
                           BlocProvider.of<LoginBloc>(context).add(
                               LoginPressedEvent(emailController.text, passwordController.text));
                           Utils().setUserId(emailController.text);
                         }
                       },style: ElevatedButton.styleFrom(
                           backgroundColor: ColorConstants.appcolor
                       ), child: const Text('Sign In',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700,fontFamily: "railBold"),)))
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
