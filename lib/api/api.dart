import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String _url = 'http://127.0.0.1:8000/api/';
  var token;

  postData(data, api) async {
    var fullURL = _url + api;
    await _getToken();
    return await http.post(fullURL,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(api) async {
    var fullURL = _url + api;
    await _getToken();
    return await http.get(fullURL, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    print(token);
  }
}
