// ignore_for_file: use_build_context_synchronously

import 'package:counter/Widgets/TextWidgets.dart';
import 'package:counter/Widgets/images_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors_constants.dart';

class DrawerLogin extends StatelessWidget {
   const DrawerLogin({Key? key}) : super(key: key);

  //PackageInfo packageInfo =await PackageInfo.fromPlatform();



  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: ColorConstants.appcolor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
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
              padding: const EdgeInsets.all(10),
              child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title: const Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title: const Text(
                    'App Information',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return  Center(
                            child: Container(
                              padding: const EdgeInsets.only(left: 0,right:0, top: 250,bottom: 350),
                              child: AlertDialog(
                                // title: Text("Alert Dialog"),
                                backgroundColor:const Color(0xFF202447).withOpacity(1),

                                shape: RoundedRectangleBorder(
                                    side:const BorderSide(color: Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
                                title: const Text('App Information',style: TextStyle(color: Colors.white),),
                                content:Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color:  Color(0xFF249238))),),
                                      child: Row(
                                        children: const [
                                           Text("User:",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color:  Color(0xFF249238))),),
                                      child: Row(
                                        children: const [
                                           Text("App Version:",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color:  Color(0xFF249238))),),
                                      child: Row(
                                        children: const [
                                           Text("Current Status:",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                          );
                        }
                    );
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 455),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(color:ColorConstants.backgroundappColor,thickness: 1),
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
        ));
  }
}
