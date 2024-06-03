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

  Future<User> findByAuth() async {
    token = await getToken();

    try {
      var response = await http.get(Uri.http(url , '/api/user-profile'),
          headers: _setHeaders());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print("user : ${response.body}");
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> store(User user) async {
    token = await getToken();
    try {
      var response = await http.post(
        Uri.http(url, '/api/user'),
        headers: _setHeaders(),
        body: user.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> update(User user) async {
    token = await getToken();
    try {
      var response = await http.put(
        Uri.http(url, '/api/user/${user.id}'),
        headers: _setHeaders(),
        body: user.toRawJson(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> destroy(int id) async {
    token = await getToken();
    try {
      var response = await http.delete(
        Uri.http(url, '/api/user/$id'),
        headers: _setHeaders(),
      );
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
