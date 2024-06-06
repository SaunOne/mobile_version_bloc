import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUser {
  String token = '';

  static final String url = networkURL.prefix;

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token') ?? '';
    return token;
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<double> findByAuth() async {
    token = await getToken();

    try {
      var response = await http.get(Uri.http(url , '/api/wallet-user'),
          headers: _setHeaders());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print("wallet : ${response.body}");
      return json.decode(response.body)['data'];
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  
}
