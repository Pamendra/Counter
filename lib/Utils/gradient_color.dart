




import 'package:flutter/cupertino.dart';

var gradient_blue = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff1654b0), Color(0xff0A2C6B)],
  ),
);

var gradient_green = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff006400), Color(0xff004d00)],
  ),
);

var gradient_demo = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff347D8E), Color(0xff174953)],
  ),
);

var gradient_login = const BoxDecoration(
  gradient:LinearGradient(
      colors: [

        Color(0xffa0ad91),
        Color(0xff9fae86),
        Color(0xff9daf7b),
        Color(0xff9cb071),
        //add more colors for gradient
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, 0.2, 0.5, 0.8]
  ),
);





