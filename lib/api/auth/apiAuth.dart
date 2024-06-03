import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_version_bloc/models/responseData.dart';
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  var token = '';

  static final String url = networkURL.prefix;

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<ResponseData> loginApi(String email, String password) async {
    var data = {
      'email': email,
      'password': password,
    };

    print("email : $email");
    print("password : $password");
    var uri = Uri.http(url, '/api/login/');

    var response = await post(uri, body: jsonEncode(data), headers: _setHeaders());

    ResponseData responseDataUser =
    ResponseData.fromJson(jsonDecode(response.body));

    print("status code ${response.statusCode}");
    responseDataUser.status = response.statusCode;
    if (response.statusCode == 200) {
      print("response body : ${response.body}");
      return responseDataUser;
    } else {
      print("response body : ${response.body}");
      return responseDataUser;
    }
  }

  // Future<User> Register(
  //   String nama_lengkap,
  //   String username,
  //   String email,
  //   String password,
  //   String tanggal_lahir,
  //   String gender,
  //   String noTelp,
  //   int id_role,
  // ) async {
  //   try {
  //     var data = {
  //       'nama_lengkap': nama_lengkap,
  //       'username': username,
  //       'email': email,
  //       'password': password,
  //       'tanggal_lahir': tanggal_lahir,
  //       'no_telp': noTelp,
  //       'gender': gender,
  //       'id_role': id_role
  //     };

  //     var uri = Uri.http(networkURL.prefix, '/api/register');
  //     var response =
  //         await post(uri, body: jsonEncode(data), headers: _setHeaders());

  //     print("status code ${response.statusCode}");

  //     if (response.statusCode == 201) {
  //       print('response : ${response.body}');
  //       var data = jsonDecode(response.body)['data'];
  //       print("data : ${data}");
  //       return User.fromJson(jsonDecode(response.body)['data']);
  //     } else {
  //       return 
  //     }
  //   } catch (e) {
  //     print('Error during registration: $e');
  //     throw Exception('Failed to register. Check your internet connection.');
  //   }
  // }

  Future<bool> ForgotPassword(String email) async {
    var data = {"email": email};

    try {
      var uri = Uri.http(networkURL.prefix, '/api/forgot-password');
      var response =
          await post(uri, body: jsonEncode(data), headers: _setHeaders());
      if (jsonDecode(response.body)['status-code'] == 200) {
        print(response.body);
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print("Error Forgot Password $e");
      throw Exception(
          "Failed to forgot password. Check your internet connection");
    }
  }

  Future<User> ResetPassword(
      String email, String token, String password) async {
    var data = {"email": email, "token": token, "password": password};

    try {
      var uri = Uri.http(networkURL.prefix, '/api/reset-password');
      var response =
          await post(uri, body: jsonEncode(data), headers: _setHeaders());

      if (response.statusCode == 200) {
        print('response : ${response.body}');
        return User.fromJson(jsonDecode(response.body)['data']);
      } else {
        print('Bad Request ');
        print('response : ${response.body}');
        return User.fromJson(jsonDecode(response.body)['data']);
      }
    } catch (e) {
      print("Error Reset Password $e");
      throw Exception(
          "Failed to Reset Password. Check your internet connection");
    }
  }

  Future<bool> cekActive(int id) async {
    try {
      var uri = Uri.http(url, '/cek-active/$id');
      var response = await get(uri);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkConnection() async {
    try {
      var url = Uri.http(networkURL.prefix);
      var response = await get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
