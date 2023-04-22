import 'package:counter/Utils/message_contants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  loginUser(String username, String password) async {
    var body = {"username": username, "password": password};

    // Map<String, String> headers = {
    //   "Content-Type": "application/json",
    //   "Accept": "application/json",
    // };

    try {
      var formData = FormData.fromMap(body);

      var response = await Dio().post('http://51.140.217.38:8000/pcds/logon/',
          data: formData);

      if (response.statusCode == 200) {
        if(response.data['status'] == 200){
          return response.data;
        }else{
          return ConstantsMessage.incorrectPassword;
        }
      } else {
        return ConstantsMessage.incorrectPassword;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
