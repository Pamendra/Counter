// ignore_for_file: use_build_context_synchronously

import 'package:counter/Utils/SizedSpace.dart';
import 'package:counter/Utils/drawertextbox.dart';
import 'package:counter/Utils/utils.dart';
import 'package:counter/Widgets/PrimaryButton.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:counter/Widgets/images_constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'colors_constants.dart';

class DrawerLogin extends StatelessWidget {
    DrawerLogin({Key? key}) : super(key: key);
  String logout = 'not logged In';
  //PackageInfo packageInfo =await PackageInfo.fromPlatform();
   openAppInfoDialog(BuildContext context) async {
     Utils().setUserId(logout);
     bool checkInternet = await Utils.checkInternet();
     PackageInfo packageInfo = await PackageInfo.fromPlatform();
     String version = packageInfo.version;
     print(version);

     return showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             shape: RoundedRectangleBorder(

                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                 side: BorderSide(
                     color: ColorConstants.primaryColor, width: 2
                 )),
             backgroundColor: ColorConstants.appcolor,
             insetPadding: EdgeInsets.all(20),

             actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
             title: Container(
                 width: MediaQuery.of(context).size.width * 0.7,
                 child: Padding(
                   padding: EdgeInsets.all(0.0),
                   child: Text(
                     "App Information",
                     style: TextStyle(
                         fontWeight: FontWeight.w900,
                         fontSize: 15.sp,
                         color: Colors.white),
                   ),
                 )),
             actions: [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     DialogTextbox2(
                         title: "User:", subtitle:'Not Logged In'
                     ),
                     DialogTextbox2(title: "App Version:", subtitle: version),
                     DialogTextbox2(
                         title: "Current Status:",
                         subtitle: checkInternet ? "Online" : "Offline"),
                     // DialogTextbox2(
                     //     title: "Last Checked for Updates:", subtitle: "N/A"),
                     const SizedBox(
                       height: 15,
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     Row(
                       children: [
                         Expanded(
                           child: PrimaryButton(
                               title: "Close",
                               onAction: () {
                                 Navigator.pop(context, true);
                               }),
                         ),
                       ],
                     ),
                    MediumSpace(),
                   ],
                 ),
               )
             ],
           );
         });
   }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          backgroundColor: ColorConstants.appcolor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              LargeSpace(),
              ListTile(
                leading: const Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                padding:  EdgeInsets.all(10.sp),
                child: ListTile(
                    shape: Border(
                        bottom: BorderSide(
                          color: ColorConstants.backgroundappColor,
                        )),
                    title: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                    onTap: ()  {

                      Navigator.pop(context);
                    }),
              ),


              Padding(
                padding:  EdgeInsets.only(top: 43.h),
                child: Column(
                  children: [
                    Container(
                      padding:  EdgeInsets.all(8.sp),
                      child: ListTile(
                          shape: Border(
                             top:BorderSide(
                               color: ColorConstants.backgroundappColor,
                             ) , bottom: BorderSide(
                                color: ColorConstants.backgroundappColor,
                              )),
                          title:  Text(
                            'App Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: Colors.white),
                          ),
                          onTap: (){
                            openAppInfoDialog(context);
                          }),
                    ),
                    SizedBox(height: 2.h,),
                    boxtextSmall(title: "Powered By:"),
                    SizedBox(height: 1.h,),
                    Image.asset(
                      ImageConstants.logoURl,
                      color: Colors.white,
                      height:10.h,
                      width: 100.h,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 1.h,),
                    // boxtextSmall(title: "® Tracsis plc"),
                    SizedBox(height: 2.h,),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
