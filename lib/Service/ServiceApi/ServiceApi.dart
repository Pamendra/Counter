

import 'package:counter/Utils/message_contants.dart';
import 'package:counter/Utils/utils.dart';
import 'package:dio/dio.dart';

class ServiceApi {
 sendData(String headcode, String train_uid, String origin_location,
      String destination_location, String origin_time, String destination_time,
      String ota, String otd, String boarding, String alightning, String delayed, String comments,
      String cancelled,String toc,String arrival_time,
     String departure_time, String date_from,String date_to, String result_source, String platform, String station) async {
   String user = await Utils().getUsererId();
   int delayedd = int.parse(delayed == '' ? '0' : delayed) ;



   var dataBody = {
      "agent_name" : user,
      "headcode": headcode,
      "train_uid": train_uid,
      "origin_location": origin_location,
      "destination_location": destination_location,
      "origin_time": origin_time,
      "destination_time": destination_time,
      "ota": ota,
      "otd": otd,
      "boarding": boarding,
      "alightning": alightning,
      "delayed": delayedd,
      "comments": comments,
      // "schedule_id": schedule_id,
      // "location_id": location_id,
      // "origin_tiploc": origin_tiploc,
      // "destination_tiploc": destination_tiploc,
      "cancelled": cancelled,
      "toc": toc,
      "arrival_time": arrival_time,
      "departure_time": departure_time,
      "date_from": date_from,
      "date_to": date_to,
      "result_source": result_source,
      "platform": platform,
      "tiploc": station,

    };


    try{

           print('send data: $dataBody');
      var formData = FormData.fromMap(dataBody);


      var dio = Dio();
      dio.options.connectTimeout = Duration(milliseconds: 30000);
      dio.options.receiveTimeout = Duration(milliseconds: 30000);


      var response = await dio.post('http://192.168.137.68:8000/pcds/api/auto-count-app-services', data: formData);

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
          return response.data;
      } else {
        return ConstantsMessage.statusError;
      }
    }catch(e){
      print('Error occurred: $e');
      return ConstantsMessage.serveError;
    }
  }
}
