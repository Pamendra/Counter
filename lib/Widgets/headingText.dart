import 'package:counter/Utils/colors_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class headingText extends StatelessWidget {
  headingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w700,color:ColorConstants.white,fontFamily:"railBold",
        fontSize:10,letterSpacing:1),);
  }


}
class DialogFieldText extends StatelessWidget {
  DialogFieldText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railBold",
      fontSize:12,),maxLines: 3,);
  }


}
class DialogField2Text extends StatelessWidget {
  DialogField2Text({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railLight",
      fontSize:10,));
  }


}
class FieldText extends StatelessWidget {
  FieldText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black,fontFamily:"railLight",
      fontSize:10,),overflow:TextOverflow.ellipsis,);
  }


}
class FieldTextHint extends StatelessWidget {
  FieldTextHint({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.black87,fontFamily:"railLight",
      fontSize:10,),overflow:TextOverflow.ellipsis,);
  }


}
class headingTextOne extends StatelessWidget {
  headingTextOne({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w600,color:Colors.white,fontFamily:"railLight",
        fontSize:17,letterSpacing:1),);
  }


}
class headingTextthree extends StatelessWidget {
  headingTextthree({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:Colors.white,fontFamily:"railLight",
        fontSize:20,letterSpacing:1),);
  }


}
class headingTextTwo extends StatelessWidget {
  headingTextTwo({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:Colors.white,fontFamily:"railLight",
        fontSize:15,letterSpacing:1),);
  }


}
class headingTextThree extends StatelessWidget {
  headingTextThree({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:Colors.white,fontFamily:"railLight",
        fontSize:12,letterSpacing:1),maxLines: 2,overflow:TextOverflow.ellipsis,);
  }


}
class superolusheadingText extends StatelessWidget {
  superolusheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,color:Colors.white,fontFamily:"railLight",
        fontSize:18,letterSpacing:1),textAlign: TextAlign.center,);
  }


}
class superheadingText extends StatelessWidget {
  superheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(fontWeight:FontWeight.w500,fontFamily:"railLight",
        fontSize:13),);
  }


}
class subheadingText extends StatelessWidget {
  subheadingText({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.w400,fontFamily:"railLight",letterSpacing: 1),);
  }


}
class subheadingTextBOLD extends StatelessWidget {
  subheadingTextBOLD({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11,fontFamily:"railBold"),);
  }


}
class subheadingTextBOLD2 extends StatelessWidget {
  subheadingTextBOLD2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        color: Colors.white, fontSize: 15, fontFamily: "railBold"),);
  }
}
class boxtextBold extends StatelessWidget {
  boxtextBold({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:10,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldH2 extends StatelessWidget {
  boxtextBoldH2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:13,fontWeight:FontWeight.w500,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldH1 extends StatelessWidget {
  boxtextBoldH1({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:13,fontWeight:FontWeight.w500,fontFamily:"railLight"),textAlign:TextAlign.center,);
  }


}
class boxtextSmall extends StatelessWidget {
  boxtextSmall({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:8,fontFamily:"railLight"),textAlign:TextAlign.center,);
  }


}
class boxtextMediumBold extends StatelessWidget {
  boxtextMediumBold({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:9,fontFamily:"railBold"),textAlign:TextAlign.justify,maxLines: 2,overflow:TextOverflow.ellipsis,);
  }


}
class boxtextMedium extends StatelessWidget {
  boxtextMedium({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:9,fontFamily:"railLight"),textAlign:TextAlign.justify,maxLines: 2,overflow:TextOverflow.ellipsis);
  }


}
class boxtextBoldUnderline extends StatelessWidget {
  boxtextBoldUnderline({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.w500,decoration:TextDecoration.underline,fontFamily:"railBold"),textAlign:TextAlign.center,);
  }


}
class boxtextBoldStart extends StatelessWidget {
  boxtextBoldStart({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:9,fontWeight:FontWeight.w500,fontFamily:"railBold"),textAlign:TextAlign.start,);
  }


}
class boxtextBoldStart2 extends StatelessWidget {
  boxtextBoldStart2({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.w500,),textAlign:TextAlign.start,);
  }


}
class boxtext extends StatelessWidget {
  boxtext({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:10,),textAlign:TextAlign.center,);
  }


}
class boxtextsumary extends StatelessWidget {
  boxtextsumary({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white70,fontSize:10,),textAlign:TextAlign.justify,);
  }


}
class boxtextBoldunderline extends StatelessWidget {
  boxtextBoldunderline({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500,),
        textAlign: TextAlign.center);
  }
}
class boxtextBoldStart3 extends StatelessWidget {
  boxtextBoldStart3({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  Widget build(BuildContext context) {
    return Text(title,style:TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.w400,),textAlign:TextAlign.start,);
  }


}