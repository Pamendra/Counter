import 'dart:convert';

import 'package:counter/Utils/message_contants.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
 sendData(String headcode, String train_uid, String origin_location,
      String destination_location, String origin_time, String destination_time,
      String ota, String otd, String joining, String alightning, String delay, String comment) async {

    var dataBody = {
      "headcode": headcode,
      "train_uid": train_uid,
      "origin_location": origin_location,
      "destination_location": destination_location,
      "origin_time": origin_time,
      "destination_time": destination_time,
      "ota": ota,
      "otd": otd,
      "joining": joining,
      "alightning": alightning,
      "delay": delay,
      "comment": comment,
    };

    try{
      final response = await http.post(Uri.parse('192.168.1.17:8000/pcds/api/manul-count-app-services?selected_dates=2023-02-23_2023-02-23&toc=CC,CH,GN,GW,GX,IL,LE,LM,LO,SE,SN,SW,TL,XR&tiploc=ABWD&export_type=station&api_key=6afyVqs6r6bW7DzI'),
          body: jsonEncode(dataBody));

      if (response.statusCode == 200) {
        return response.body;

      }else{
        Fluttertoast.showToast(msg: 'Login Error');
      }
    }catch(e){
      Fluttertoast.showToast(msg: 'Server error');
    }
  }
}
