import 'package:counter/Screens/odStation.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Sqflite/Model/service_model.dart';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Widgets/InputFormatter.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';

class ManualEntry extends StatefulWidget {
  const ManualEntry({super.key});

  @override
  State<ManualEntry> createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  TextEditingController comment = TextEditingController();
  final TextEditingController _ota = TextEditingController();
  final TextEditingController _otd = TextEditingController();
  final TextEditingController _join = TextEditingController();
  final TextEditingController _alight = TextEditingController();
  final TextEditingController oLocation = TextEditingController();
  final TextEditingController oTime = TextEditingController();
  final TextEditingController dLocation = TextEditingController();
  final TextEditingController dTime = TextEditingController();
  final TextEditingController headCode = TextEditingController();
   TextEditingController trainUid = TextEditingController();
  final _delay = TextEditingController();

  bool _otaactive = false;
  bool _otDactive = false;
  bool _joinactive = false;
  bool _alightactive = false;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNod = FocusNode();
  final FocusNode _focusNo = FocusNode();
  final FocusNode _focusN = FocusNode();
  bool _showNumberPicker = false;
  int _selectedNumber = 1;
  final TiplocDatabaseHelper _helper = TiplocDatabaseHelper();
  bool _isLoading = false;

  String trainID = "";
  Train? trainData = Train(tiploc: '', description: '');
  String train = "";
  Train? trainD = Train(tiploc: '', description: '');

  Future<void> getTrainID(BuildContext context) async {


    /// Check  Auto route data receving
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const TrainStation()),);
    setState(() {
      if (result.toString() != "null") {
        trainData = result;
        trainID = trainData!.description.toString();
      } if(train.toString() == trainID.toString()){
        trainID = '';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF202447).withOpacity(0.7),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
              title: const Text("Error",style: TextStyle(color: Colors.white),),
              content: const Text("Origin and destination locations cannot be the same, please change the Origin",style: TextStyle(color: Colors.white),),
              actions: [
                TextButton(
                  child: const Text("OK",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        trainID = trainData!.description.toString();
      }
    });
  }

  Future<void> getTrain(BuildContext context) async {


    /// Check  Auto route data receving
    final res = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const TrainStation()),);
    setState(() {
      if (res.toString() != "null") {
        trainD = res;
        train = trainD!.description.toString();
      }if(trainID.toString() == train.toString()){
        train = '';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF202447).withOpacity(0.7),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
              title: const Text("Error",style: TextStyle(color: Colors.white),),
              content: const Text("Origin and destination locations cannot be the same, please change the destination",style: TextStyle(color: Colors.white),),
              actions: [
                TextButton(
                  child: const Text("OK",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        train = trainD!.description.toString();
      }
    });
  }

  Future<void> fetchdata() async{
    setState(() {
      _isLoading = true;
    });
    await _helper.fetchdatalm();
    setState(() {
      _isLoading = false;
    });
  }



  @override
  void dispose() {
    _ota.dispose();
    _otd.dispose();
    _join.dispose();
    _alight.dispose();
    _focusNode.dispose();
    _focusNod.dispose();
    _focusNo.dispose();
    _focusN.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showNumberPicker = _focusNode.hasFocus;
      });
    });
    _focusNod.addListener(() {
      setState(() {
        _showNumberPicker = _focusNod.hasFocus;
      });
    });
    _focusNo.addListener(() {
      setState(() {
        _showNumberPicker = _focusNo.hasFocus;
      });
    });
    _focusN.addListener(() {
      setState(() {
        _showNumberPicker = _focusN.hasFocus;
      });
    });
  }

  _showInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF202447).withOpacity(0.7),
          shape: RoundedRectangleBorder(side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
          title: const Text('Enter a Value',style: TextStyle(color: Colors.white),),
          content: TextField(
            keyboardType: TextInputType.phone,
            controller: _delay,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide:  BorderSide(width: 3,color: Color(0xFF249238)),
              )
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(_delay.text);
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorConstants.appcolor,
      title: const Text('Manual Entry',style: TextStyle(fontFamily:"Aleo",),),
      ),
      body:  ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator:const LoadingBar(),
        inAsyncCall: _isLoading ? true:false,
        child: Container(
          height: 1000.h,
          decoration: gradient_login,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  /// Head code
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText1( title: 'Head Code',),
                            SizedBox(
                              width:85.w,
                              height: 6.h,
                              child: TextFormField(
                                textCapitalization: TextCapitalization.characters,
                                controller: headCode,
                                decoration:  InputDecoration(
                                  suffixIcon: Icon(Icons.confirmation_number_rounded,color: ColorConstants.appcolor,),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green)
                                  ),
                                  border: const OutlineInputBorder(

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),

                  /// Train Uid
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            headingText1( title: 'Train Uid',),

                            SizedBox(
                              width: 85.w,
                              height: 6.h,
                              child: TextFormField(
                                textCapitalization: TextCapitalization.characters,
                                controller: trainUid,
                                decoration:  InputDecoration(
                                  suffixIcon: Icon(Icons.train,color: ColorConstants.appcolor,),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green)
                                  ),
                                  border: const OutlineInputBorder(

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText1( title: 'Origin Location',),
                      GestureDetector(
                        onTap: () {
                          getTrainID(context);
                        },
                        child: Container(
                          width: 85.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trainID == ""
                                      ? "Select Station"
                                      : trainID.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  CupertinoIcons.search,
                                  color: ColorConstants.appcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText1( title: 'Destination Location',),
                      GestureDetector(
                        onTap: () {
                            getTrain(context);
                        },
                        child: Container(
                          width: 85.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  train == ""
                                      ? "Select Station"
                                      : train.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  CupertinoIcons.search,
                                  color: ColorConstants.appcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                      const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Origin Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              headingText1( title: 'Origin Time',),

                              SizedBox(
                                width: 40.w,
                                height: 6.h,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: oTime,
                                  maxLength: 5,
                                  inputFormatters: [
                                    TimeInputFormatter(),
                                  ],
                                  decoration:  InputDecoration(
                                    suffixIcon: Icon(Icons.access_time,color: ColorConstants.appcolor,),
                                    counterText: '',
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green)
                                    ),
                                    border: const OutlineInputBorder(

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),


                          /// Destination Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              headingText1( title: 'Destination Time',),

                              SizedBox(
                                width: 40.w,
                                height: 6.h,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  maxLength: 5,
                                  controller: dTime,
                                  inputFormatters: [
                                    TimeInputFormatter(),
                                  ],
                                  decoration:  InputDecoration(
                                    suffixIcon: Icon(Icons.access_time,color: ColorConstants.appcolor,),
                                    counterText: '',
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green)
                                    ),
                                    border: const OutlineInputBorder(

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                  //   child: Container(
                  //     decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                  //     child: Row(
                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //
                  //         const Text('OTA',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                  //         const SizedBox(width: 77,),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: SizedBox(
                  //             width: 150,
                  //             height: 50,
                  //             child: TextFormField(
                  //               maxLength: 4,
                  //               focusNode: _focusNode,
                  //               onTap: () {
                  //                 _focusNode.requestFocus();
                  //                 setState(() {
                  //                   _otaactive = true;
                  //                   _otDactive = false;
                  //                   _joinactive = false;
                  //                   _alightactive = false;
                  //                   _selectedNumber = int.tryParse(_ota.text) ?? 0;
                  //                   _ota.selection = TextSelection.fromPosition(
                  //                       TextPosition(offset: _ota.text.length));
                  //                 });
                  //               },
                  //               controller: _ota,
                  //               keyboardType: TextInputType.phone,
                  //               onChanged:  (value) {
                  //                 setState(() {
                  //                   _selectedNumber = int.tryParse(value) ?? 0;
                  //                 });
                  //               },
                  //               decoration: const InputDecoration(
                  //                 counterText: '',
                  //                 fillColor: Colors.white,
                  //                 filled: true,
                  //                 focusedBorder: OutlineInputBorder(
                  //                     borderSide: BorderSide(color: Colors.black)
                  //                 ),
                  //                 border: OutlineInputBorder(
                  //
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(left: 22,right: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.green)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: headingText1( title: 'OTD',),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 40.w,
                                      height:6.h,
                                      child: TextFormField(
                                        maxLength: 4,
                                        focusNode: _focusNod,
                                        onChanged:  (value) {
                                          setState(() {
                                            _selectedNumber = int.tryParse(value) ?? 0;
                                          });
                                        },
                                        controller: _otd,
                                        onTap: () {
                                          _focusNod.requestFocus();
                                          setState(() {
                                            _otaactive = false;
                                            _otDactive = true;
                                            _joinactive = false;
                                            _alightactive = false;
                                            _selectedNumber = int.tryParse(_otd.text) ?? 0;
                                            _otd.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _otd.text.length));
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          counterText: '',
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.green)
                                          ),
                                          border: OutlineInputBorder(

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                             // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.green)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: headingText1( title: 'JOINING',),
                                  ),
                                  const SizedBox(width: 48,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 40.w,
                                      height: 6.h,
                                      child: TextFormField(
                                        maxLength: 4,
                                        focusNode: _focusNo,
                                        onChanged:  (value) {
                                          setState(() {
                                            _selectedNumber = int.tryParse(value) ?? 0;
                                          });
                                        },
                                        controller: _join,
                                        onTap: () {
                                          _focusNo.requestFocus();
                                          setState(() {
                                            _otaactive = false;
                                            _otDactive = false;
                                            _joinactive = true;
                                            _alightactive = false;
                                            _selectedNumber = int.tryParse(_join.text) ?? 0;
                                            _join.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _join.text.length));
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          counterText: '',
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.green)
                                          ),
                                          border: OutlineInputBorder(

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              //decoration:  BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.green)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: headingText1( title: 'ALIGHTNING',),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 40.w,
                                      height: 6.h,
                                      child: TextFormField(
                                        maxLength: 4,
                                        focusNode: _focusN,
                                        onChanged:  (value) {
                                          setState(() {
                                            _selectedNumber = int.tryParse(value) ?? 0;
                                          });
                                        },
                                        controller: _alight,
                                        onTap: () {
                                          _focusN.requestFocus();
                                          setState(() {
                                            _otaactive = false;
                                            _otDactive = false;
                                            _joinactive = false;
                                            _alightactive = true;
                                            _selectedNumber = int.tryParse(_alight.text) ?? 0;
                                            _alight.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _alight.text.length));
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          counterText: '',
                                          fillColor: Colors.white,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.green)
                                          ),
                                          border: OutlineInputBorder(

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (_showNumberPicker)
                          RawScrollbar(
                            //trackVisibility: true,
                            thumbColor: ColorConstants.appcolor,
                            trackColor: Colors.white,
                            //thumbVisibility: true,
                            thickness: 5,
                            radius: const Radius.circular(2),

                            child: SizedBox(
                              width: 30.w,
                              child: NumberPicker(
                                selectedTextStyle: const TextStyle(fontSize: 22),
                                value: _selectedNumber,
                                itemHeight: 25,
                                itemCount: 10,
                                minValue: 0,
                                maxValue: 1001,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNumber = value;

                                    if (_otaactive) {
                                      _ota.text = value.toString();
                                      _ota.text = '$_selectedNumber';
                                      _ota.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _ota.text.length));
                                    } else if (_otDactive) {
                                      _otd.text = value.toString();
                                      _otd.text = '$_selectedNumber';
                                      _otd.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _otd.text.length));
                                    }else if (_joinactive) {
                                      _join.text = value.toString();
                                      _join.text = '$_selectedNumber';
                                      _join.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _join.text.length));
                                    }else if (_alightactive) {
                                      _alight.text = value.toString();
                                      _alight.text = '$_selectedNumber';
                                      _alight.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _alight.text.length));
                                    }
                                  });
                                },
                              ),
                            ),
                          ),


                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: SizedBox(
                      width: 85.w,
                      height: 6.h,
                      child: TextFormField(
                        controller: comment ,
                        decoration: InputDecoration(
                            suffixIcon: PopupMenuButton(
                              icon:  Icon(Icons.add,color: ColorConstants.appcolor,),
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value:'Great',
                                    child: Text('Great'),
                                  ),
                                  const PopupMenuItem(
                                    value:  'Good',
                                    child: Text('Good'),
                                  ),
                                  const PopupMenuItem(
                                    value:  'Excellent',
                                    child: Text('Excellent'),
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                setState(() {
                                  comment.text = value;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Comments',
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          width: 43.w,
                          height: 5.h,
                          child: ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          },style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appcolor
                          ),
                              child: const Text('Cancellation')),
                        ),
                      ),
                        const SizedBox(width: 7,),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: SizedBox( width: 50.w,
                              height: 5.h,
                              child: ElevatedButton(onPressed: () async {
                                String value = await _showInputDialog();
                                print('The user entered: $value');
                              },style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.appcolor
                              ),
                                  child: const Text('Delay'))),
                        )),
                      ]
                  ),
                  Padding(padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5.h,
                            child: ElevatedButton(onPressed: (){
                              if(headCode.text.isNotEmpty && trainUid.text.isNotEmpty && _otd.text.isNotEmpty &&
                                  _join.text.isNotEmpty && _alight.text.isNotEmpty && trainID.isNotEmpty && train.isNotEmpty)
                              {
                                // Navigator.pop(context, MaterialPageRoute(builder: (context) => TrainList(station: widget.station,) ));
                                Navigator.pop(context, true);
                                _insert();
                              }else{
                                Fluttertoast.showToast(msg: 'Please enter values');
                              }
                            },style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.appcolor
                            ),
                                child: const Text('Save'))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _insert() async {


    Database? db = await LocalDatabase.instance.database;

    // row to insert
    Map<String, dynamic> row = {
      LocalDatabase.columnHEADCODE  : headCode.text,
      LocalDatabase.columnOTA : _ota.text,
      LocalDatabase.columnOTD  : _otd.text,
      LocalDatabase.columnJOIN  : _join.text,
      LocalDatabase.columnALIGHT  : _alight.text,
      LocalDatabase.columnCOMMENT  : comment.text,
      LocalDatabase.columnOLOCATION  : trainID.toString(),
      LocalDatabase.columnOTIME  : oTime.text,
      LocalDatabase.columnDLOCATION  : train.toString(),
      LocalDatabase.columnDTIME  : dTime.text,
      LocalDatabase.columnDELAY  : _delay.text,
      LocalDatabase.columnTRAIN_UID  : trainUid.text,
    };
    if (kDebugMode) {
      print(row);
    }
    // do the insert and get the id of the inserted row
    int id = await db!.insert(LocalDatabase.table, row);

    if (kDebugMode) {
      print(await db.query(LocalDatabase.table));
    }
  }
}
