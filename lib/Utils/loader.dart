import 'package:counter/Utils/colors_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatefulWidget {
  bool? _isLoading;


  Loader(this._isLoading);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
bool isLoading = false;

@override
void initState() {
  super.initState();
  isLoading = widget._isLoading ?? false;
}

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Padding(
        padding: const EdgeInsets.all(115),
        child: Dialog(
          backgroundColor:
          const Color(0xFF202447).withOpacity(0.7),
          shape: RoundedRectangleBorder(
              side:
              const BorderSide(color: Color(0xFF249238), width: 3),
              borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: ColorConstants.primaryColor, width: 2),
              borderRadius:
              const BorderRadius.all(Radius.circular(8)),
              color: Colors.black87,
              shape: BoxShape.rectangle,
            ),
            child: Lottie.asset(
                'assets/animations/loading1.json',
                frameRate: FrameRate.max,
                height: 50),
          ),
        ),
      ),
    );
  }
}
