import 'package:counter/Utils/message_contants.dart';
import 'package:dio/dio.dart';

class LoginService {
  loginUser(String username, String password) async {
    var body = {"username": username, "password": password};

    try {
      var formData = FormData.fromMap(body);

      var response = await Dio().post('http://192.168.137.183:8000/pcds/logon', data: formData);

      if (response.statusCode == 200) {
        if(response.data['status'] == 200){
          return response.data;
        }else if(response.data['status'] == 302){
          return ConstantsMessage.incorrectPassword;
        }
        // return response.data;
      } else {
        return ConstantsMessage.incorrectPassword;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
