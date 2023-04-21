import 'package:counter/Utils/message_contants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  loginUser(String username, String password) async {
    var dataBody = {"username": username, "password": password};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    try {
      final response = await http.post(
          Uri.parse('https://dummyjson.com/auth/login'),
          body: jsonEncode(dataBody),
          headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return ConstantsMessage.incorrectPassword;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
