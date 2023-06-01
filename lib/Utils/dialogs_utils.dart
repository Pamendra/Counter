import 'package:counter/Widgets/PrimaryButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/TextWidgets.dart';
import 'colors_constants.dart';

class Dialogs {

  static showValidationMessage(BuildContext context, String title) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: ColorConstants.primaryColor, width: 2)),
            backgroundColor: Colors.black87,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        subheadingText(
                          title: 'Message',
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            color: ColorConstants.primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    subheadingText(title: "$title"),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
