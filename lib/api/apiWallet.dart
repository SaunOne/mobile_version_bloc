import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/user.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiWallet {
  String token = '';

  static final String url = networkURL.prefix + networkURL.endpoint;

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
      
      var uri = Uri.parse(url + "wallet-user");
      print("uri wallet : $uri");
      var response = await http.get(uri,
          headers: _setHeaders());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print("response : ${response.body}");
      double wallet = (json.decode(response.body)['data']['jumlah_saldo']).toDouble();
      print("wallet : ${wallet}");
      return wallet;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  
}
